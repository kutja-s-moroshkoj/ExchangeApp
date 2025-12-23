//
//  CoinDataDetailService.swift
//  ScreenEx
//
//  Created by Ростислав on 23.12.2025.
//

import Foundation
internal import Combine

class CoinDataDetailService {
    
    @Published var coinDetails: CoinDataModel? = nil
    
    var coinDetailSubscriptions: AnyCancellable?
    let coin: ExchangeModel
    
    init(coin: ExchangeModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        // Базовый URL
        let baseURL = "https://api.coingecko.com/api/v3/coins/\(coin.id)"
        
        // Параметры запроса
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "localization", value: "false"),
            URLQueryItem(name: "tickers", value: "false"),
            URLQueryItem(name: "market_data", value: "false"),
            URLQueryItem(name: "community_data", value: "false"),
            URLQueryItem(name: "developer_data", value: "false"),
            URLQueryItem(name: "sparkline", value: "false"),
            URLQueryItem(name: "include_categories_details", value: "false")
        ]
        
        // Создание компонентов для добавления  параметров
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems
        
        // Собирает конечный URL
        guard let url = urlComponents.url else {
            fatalError("Не получилось собрать URL из urlComponents")
        }

        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
        "accept": "application/json",
        "x-cg-demo-api-key" : "CG-akbL7MnYLPmX7CAAnzEaUtyg"
        ]
        
        coinDetailSubscriptions = NetworkManager.downLoad(request: request)
            .decode(type: CoinDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleComplition, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscriptions?.cancel()
            })
    }
    
}
