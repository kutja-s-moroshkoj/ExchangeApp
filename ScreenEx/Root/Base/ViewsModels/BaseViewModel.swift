//
//  BaseViewModel.swift
//  ScreenEx
//
//  Created by Ростислав on 04.12.2025.
//

import Foundation
internal import Combine

class BaseViewModel: ObservableObject {
    
    @Published var statArray: [StatisticModel] = []
    @Published var exchangeCoin: [ExchangeModel] = []
    @Published var portfolioCoin: [ExchangeModel] = []
    
    private let exchangeDataService = MarketDataSrvice()
    
    private let globalDataService = GlobalDataService()
    
    private let portfolioDataService = PortfolioDataService()
    
    var cancelables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
//        exchangeDataService.$exchangeCoins
//            .sink { [weak self] returnedCoins in
//                self?.exchangeCoin = returnedCoins
//            }
//            .store(in: &cancelables)
        
        // обновляем массивexchangeCoin
        $searchText
            .combineLatest(exchangeDataService.$exchangeCoins)
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
        
        // обновляем массив statArray
        globalDataService.$marketData
            .map { globalData -> [StatisticModel] in
                var stats: [StatisticModel] = []
                
                guard let data = globalData else {
                    return stats
                }
                let marketCap = StatisticModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = StatisticModel(title: "Portfolio Value", value: "0.00", percentageChange: 0)
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portfolio
                ])
                return stats
            }
            .sink { [weak self] returnedStats in
                self?.statArray = returnedStats
            }
            .store(in: &cancelables)
        
        // обновляем portfolioCoin
        $exchangeCoin
            .combineLatest(portfolioDataService.$savedEntities)
            .map { coinModels, portfolioEntities -> [ExchangeModel] in
                coinModels.compactMap { coin -> ExchangeModel? in
                    guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoin = returnedCoins
            }
            .store(in: &cancelables)
    }
    
    func updatePortfolio(coin: ExchangeModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
}
