//
//  CoinImage.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import SwiftUI
internal import Combine

struct CoinImage: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: ExchangeModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.appColor.secondaryTextColor)
            }
        }
        
    }
}

#Preview {
    CoinImage(coin: DeveloperPreview.shared.coin)
}
