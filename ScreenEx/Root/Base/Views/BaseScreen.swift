//
//  BaseScreen.swift
//  ScreenEx
//
//  Created by Ростислав on 02.12.2025.
//

import SwiftUI

struct BaseScreen: View {
    
    @State private var goToTheNextScreen: Bool = false
    @State private var showPortfolioScreen: Bool = false
    
    @EnvironmentObject private var viewModel: BaseViewModel
    
    var body: some View {
        
        ZStack {
            //задний фон
            Color.appColor.backgroundAppcolor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioScreen) {
                    PortfolioScreen()
                        .environmentObject(viewModel)
                }
            //контент
            VStack{
                baseScreenHeader
                
                BaseStatView(showNextScreen: $goToTheNextScreen)
                
                SearchBar(searchText: $viewModel.searchText)
                
                columnsTitles
                
                if !goToTheNextScreen {
                    exchangeCoinLis
                    .transition(.move(edge: .leading))
                }
                if goToTheNextScreen {
                    portfolioCoinLis
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        BaseScreen()
            .toolbar(.hidden)
    }
    .environmentObject(BaseViewModel())
}


extension BaseScreen {
    private var baseScreenHeader: some View {
        HStack {
            CustomButton(iconName: goToTheNextScreen ? "plus.viewfinder" : "info.square.fill")
                .onTapGesture {
                    if goToTheNextScreen {
                        showPortfolioScreen.toggle()
                    }
                }
                .background(CustomButtonAnimation(animate: $goToTheNextScreen))
            Spacer()
            Text(goToTheNextScreen ? "PORTFOLIO" : "EXCHANGE")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.appColor.accentAppcolor)
                .animation(.none)
            Spacer()
            CustomButton(iconName: "arrowtriangle.forward")
                .rotationEffect(Angle(degrees: goToTheNextScreen ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        goToTheNextScreen.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var exchangeCoinLis: some View {
        List {
            ForEach(viewModel.exchangeCoin) { coin in
                CoinCell(coin: coin, showHoldings: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinLis: some View {
        List {
            ForEach(viewModel.portfolioCoin) { coin in
                CoinCell(coin: coin, showHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
            }
        }
        .listStyle(.plain)
    }
    
    private var columnsTitles: some View {
        HStack {
            Text("TICKER")
            Spacer()
            if goToTheNextScreen {
                Text("HOLDINGS")
            }
            Text("PRICE")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.appColor.secondaryTextColor)
        .padding(.horizontal)
    }
}
