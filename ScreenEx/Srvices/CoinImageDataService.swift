//
//  CoinImageDataService.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import Foundation
import SwiftUI
internal import Combine

class CoinImageDataService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscriptions: AnyCancellable?
    private let coin: ExchangeModel
    
    init(coin: ExchangeModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        
        let baseURL = coin.image
        
        let urlComponents = URLComponents(string: baseURL)!
        
        guard let url = urlComponents.url else {
            fatalError("Не получилось собрать URL в классе CoinImageDataService")
        }
        
        let request = URLRequest(url: url)
        
        imageSubscriptions = NetworkManager.downLoad(request: request)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleComplition, receiveValue: { [weak self] returnedImages in
                self?.image = returnedImages
                self?.imageSubscriptions?.cancel()
            })
    }
}
