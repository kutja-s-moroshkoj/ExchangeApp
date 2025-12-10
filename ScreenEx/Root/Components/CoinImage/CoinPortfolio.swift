//
//  CoinPortfolio.swift
//  ScreenEx
//
//  Created by Ростислав on 10.12.2025.
//

import SwiftUI

struct CoinPortfolio: View {
    
    let coin: ExchangeModel
    
    var body: some View {
        VStack {
            CoinImage(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.appColor.accentAppcolor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.appColor.secondaryTextColor)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinPortfolio(coin: DeveloperPreview.shared.coin)
}
