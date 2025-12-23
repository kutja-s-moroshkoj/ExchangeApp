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
    
    @StateObject var viewModel: DetailViewModel

    
    init(coin: ExchangeModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Инициализация для \(coin.name)")
    }
    
    var body: some View {
        
        Text("1312")
    }
}

#Preview {
    DetailScreen(coin: DeveloperPreview.shared.coin)
}
