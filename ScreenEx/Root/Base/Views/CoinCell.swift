//
//  CoinCell.swift
//  ScreenEx
//
//  Created by Ростислав on 03.12.2025.
//

import SwiftUI

struct CoinCell: View {
    
    let coin: ExchangeModel
    
    var body: some View {
        
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
            Spacer()
                
            VStack {
                Text("\(coin.currentPrice)")
                    .bold()
                    .foregroundStyle(Color.appColor.accentAppcolor)
                Text("\(coin.priceChangePercentage24H ?? 0)%")
                    .foregroundStyle(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.appColor.colorPricesUp : Color.appColor.colorPricesDown
                    )
                
            }
        }
        
    }
}

#Preview {
    CoinCell(coin: DeveloperPreview.shared.coin)
}
