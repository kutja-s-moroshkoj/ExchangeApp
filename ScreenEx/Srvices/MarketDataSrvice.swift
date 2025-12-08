//
//  MarketDataSrvice.swift
//  ScreenEx
//
//  Created by Ростислав on 04.12.2025.
//

import Foundation
internal import Combine

class MarketDataSrvice {
    
    @Published var exchangeCoins: [ExchangeModel] = []
    
    var coinSubscriptions: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        
        // Базовый URL
        let baseURL = "https://api.coingecko.com/api/v3/coins/markets"
        
        // Параметры запроса
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "250"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24")
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
        
        coinSubscriptions = NetworkManager.downLoad(request: request)
            .decode(type: [ExchangeModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleComplition, receiveValue: { [weak self] returnedCoins in
                self?.exchangeCoins = returnedCoins
                self?.coinSubscriptions?.cancel()
            })
    }
    
}
