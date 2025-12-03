//
//  CoinCell.swift
//  ScreenEx
//
//  Created by Ростислав on 03.12.2025.
//

import SwiftUI

struct CoinCell: View {
    
    let coin: ExchangeModel
    let showHoldings: Bool
    
    var body: some View {
        
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldings {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview {
    CoinCell(coin: DeveloperPreview.shared.coin, showHoldings: true)
}

extension CoinCell {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.appColor.secondaryTextColor)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.appColor.accentAppcolor)
        }
    }
    private var centerColumn: some View {
        VStack {
            Text(coin.currentHoldingsValue.asCurrencyWith6FractionDigits())
                .bold()
            
            Text((coin.currentHoldings ?? 0).fromNumberToString())
        }
        .foregroundStyle(Color.appColor.accentAppcolor)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6FractionDigits())
                .bold()
                .foregroundStyle(Color.appColor.accentAppcolor)
            Text(coin.priceChangePercentage24H?.addPercentString() ?? "none")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.appColor.colorPricesUp : Color.appColor.colorPricesDown
                )
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
