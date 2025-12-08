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
//        dataService.$exchangeCoins
//            .sink { [weak self] returnedCoins in
//                self?.exchangeCoin = returnedCoins
//            }
//            .store(in: &cancelables)
        $searchText
            .combineLatest(dataService.$exchangeCoins)
            .map { text, startingCoins -> [ExchangeModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                let lowercasedText = text.lowercased()
                
                let filteredCoins = startingCoins.filter { coin -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
                }
                return filteredCoins
            }
            .sink { [weak self] returnedCoins in
                self?.exchangeCoin = returnedCoins
            }
            .store(in: &cancelables)
    }
}
