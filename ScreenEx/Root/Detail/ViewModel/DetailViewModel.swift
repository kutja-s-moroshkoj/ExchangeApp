//
//  DetailViewModel.swift
//  ScreenEx
//
//  Created by Ростислав on 23.12.2025.
//

import Foundation
internal import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    
    private let coinDetailService : CoinDataDetailService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var coin: ExchangeModel
    
    init(coin: ExchangeModel) {
        self.coin = coin
        self.coinDetailService = CoinDataDetailService(coin: coin)
        self.addSubscribbers()
    }
    
    private func addSubscribbers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ coinDataModel, coinModel -> (overView: [StatisticModel], additional: [StatisticModel]) in
                // overView
                let price = coinModel.currentPrice.asCurrencyWith6FractionDigits()
                let priceChangePercentage = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChangePercentage)
                
                let marketCap = (coinModel.marketCap?.formattedWithAbbreviations() ?? "") + "$"
                let marketCapChange  = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title: "Rank", value: rank)
                
                let volume = (coinModel.totalVolume?.formattedWithAbbreviations() ?? "") + "$"
                let volumeStat = StatisticModel(title: "Volume", value: volume)
                
                var overViewArray: [StatisticModel] = [
                    priceStat, marketCapStat, rankStat, volumeStat
                ]
                
                // additional
                let high = (coinModel.high24H?.asCurrencyWith6FractionDigits() ?? "")
                let highStat = StatisticModel(title: "24h High", value: high)
                
                let low = (coinModel.low24H?.asCurrencyWith6FractionDigits() ?? "")
                let lowStat = StatisticModel(title: "24h Low", value: low)
                
                let priceChange = (coinModel.priceChange24H?.asCurrencyWith6FractionDigits() ?? "")
                let priceChangePercentage2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: priceChangePercentage2)
                
                let marketCapCHange = (coinModel.marketCapChange24H?.asCurrencyWith6FractionDigits() ?? "")  + "$"
                let marketCapChangePercentage24H = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapCHange, percentageChange: priceChangePercentage2)
                
                let blockTime = coinDataModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDataModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algoritm", value: hashing)
                
                let additionalArray: [StatisticModel] = [
                    highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
                ]
        
                return (overViewArray, additionalArray)
            })
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overView
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
    
}
