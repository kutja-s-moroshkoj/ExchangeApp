//
//  GlobalDataService.swift
//  ScreenEx
//
//  Created by Ростислав on 09.12.2025.
//
//CG-akbL7MnYLPmX7CAAnzEaUtyg


import Foundation
internal import Combine

class GlobalDataService {
    
    @Published var marketData: GlobalData? = nil
    
    var marketDataSubscriptions: AnyCancellable?
    
    init() {
        getGlobalData()
    }
    
    func getGlobalData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            fatalError("Не получилось использовать URL в классе GlobalDataService")
        }

        // Создание запроса
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
        "accept": "application/json",
        "x-cg-demo-api-key" : "CG-akbL7MnYLPmX7CAAnzEaUtyg"
        ]
        
        marketDataSubscriptions = NetworkManager.downLoad(request: request)
            .decode(type: MarketDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleComplition, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscriptions?.cancel()
            })
    }
}
