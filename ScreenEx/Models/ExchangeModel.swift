//
//  ExchangeModel.swift
//  ScreenEx
//
//  Created by Ростислав on 03.12.2025.
//
//
//
//    let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
//    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//    let queryItems: [URLQueryItem] = [
//        URLQueryItem(name: "vs_currency", value: "usd"),
//        URLQueryItem(name: "order", value: "market_cap_desc"),
//        URLQueryItem(name: "per_page", value: "250"),
//        URLQueryItem(name: "page", value: "1"),
//        URLQueryItem(name: "sparkline", value: "true"),
//        URLQueryItem(name: "price_change_percentage", value: "24"),
//    ]
//    components.queryItems = components.queryItems.map {$0 + queryItems} ?? queryItems
//    
//    var request = URLRequest(url: components.url!)
//    request.httpMethod = "GET"
//    request.timeoutInterval = 10
//    request.allHTTPHeaderFields = [
//        "accept": "application/json",
//        "x-cg-demo-api-key" : "CG-akbL7MnYLPmX7CAAnzEaUtyg"
//    ]
//    
//    let (data, _) = try await URLSession.shared.data(for: request)
//    print(String(decoding: data, as: UTF8.self))
//
//

import Foundation

struct ExchangeModel {
    
    
    
}
