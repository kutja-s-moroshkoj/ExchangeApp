//
//  DetailScreen.swift
//  ScreenEx
//
//  Created by Ростислав on 20.12.2025.
//

import SwiftUI

struct DetailLoadingScreen: View {
    @Binding var coin: ExchangeModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailScreen(coin: coin)
            }
        }
    }
}

struct DetailScreen: View {
    
    @StateObject private var viewModel: DetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: ExchangeModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                
                overViewTitle
                Divider()
                
                overViewGrid
                
                detailseTitle
                Divider()
                
                detailseGrid
                
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
}

#Preview {
    NavigationStack {
        DetailScreen(coin: DeveloperPreview.shared.coin)
    }
}


extension DetailScreen {
    private var overViewTitle: some View {
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundStyle(Color.appColor.accentAppcolor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var detailseTitle: some View {
        Text("Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.appColor.accentAppcolor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticComponent(statistic: stat)
                }
            }
    }
    
    private var detailseGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticComponent(statistic: stat)
                }
            }
    }
}
