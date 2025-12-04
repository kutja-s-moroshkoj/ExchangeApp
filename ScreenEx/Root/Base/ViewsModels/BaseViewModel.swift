//
//  BaseViewModel.swift
//  ScreenEx
//
//  Created by Ростислав on 04.12.2025.
//

import Foundation
internal import Combine

class BaseViewModel: ObservableObject {
    @Published var exchangeCoin: [ExchangeModel] = []
    @Published var portfolioCoins: [ExchangeModel] = []
    
    init () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.exchangeCoin.append(DeveloperPreview.shared.coin)
            self.portfolioCoins.append(DeveloperPreview.shared.coin)
        }
    }
}
