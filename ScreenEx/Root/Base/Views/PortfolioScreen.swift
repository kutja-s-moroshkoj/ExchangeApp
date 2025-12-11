//
//  PortfolioScreen.swift
//  ScreenEx
//
//  Created by Ростислав on 10.12.2025.
//

import SwiftUI

struct PortfolioScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var viewModel: BaseViewModel
    @State private var selectedCoin: ExchangeModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBar(searchText: $viewModel.searchText)
                    
                    coinListHorisontal
                    
                    if selectedCoin != nil {
                        portfolioInfo
                    }
                }
            }
            .navigationTitle(Text("Edit Portfolio"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveTollBarButton
                }
            }
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelection()
                }
            }
        }
    }
}

#Preview {
    PortfolioScreen()
        .environmentObject(BaseViewModel())
}


extension PortfolioScreen {
    var coinListHorisontal: some View {
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.exchangeCoin) { coin in
                    CoinPortfolio(coin: coin)
                        .frame(width: 80)
                        .padding(6)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(selectedCoin?.id == coin.id ? Color.appColor.accentAppcolor : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical)
            .padding(.leading)
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInfo: some View {
        VStack {
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6FractionDigits() ?? "")
            }
            Divider()
            HStack{
                Text("Portfolio amount")
                Spacer()
                TextField("Amount", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith6FractionDigits())
            }
        }
        .padding()
        .font(.headline)
    }
    
    private var saveTollBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .foregroundStyle(Color.appColor.accentAppcolor)
                .opacity(showCheckmark ? 1 : 0)
            Button {
                saveButtonPressed()
            } label: {
                Text("save".uppercased())
                    .foregroundStyle(Color.appColor.accentAppcolor)
            }
            .opacity (
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1 : 0
            )
        }
    }
    private func saveButtonPressed() {
        
        guard let coin = selectedCoin else { return }
        
        //логика сохранения в портфолио
        
        //логика отображения чекмарк
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelection()
        }
        
        // скрыть клавиатуру
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelection() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
