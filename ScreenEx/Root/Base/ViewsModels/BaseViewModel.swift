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
    
    private let dataService = MarketDataSrvice()
    var cancelables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$exchangeCoins
            .sink { [weak self] returnedCoins in
                self?.exchangeCoin = returnedCoins
            }
            .store(in: &cancelables)
    }
}
