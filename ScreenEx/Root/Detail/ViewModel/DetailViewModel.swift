//
//  DetailViewModel.swift
//  ScreenEx
//
//  Created by Ростислав on 23.12.2025.
//

import Foundation
internal import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService : CoinDataDetailService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: ExchangeModel) {
        self.coinDetailService = CoinDataDetailService(coin: coin)
        self.addSubscribbers()
    }
    
    private func addSubscribbers() {
        
        coinDetailService.$coinDetails
            .sink { returnedVoinDetails in
                print("Полученые данные монеты: \(String(describing: returnedVoinDetails))")
            }
            .store(in: &cancellables)
    }
    
}
