//
//  CoinImageViewModel.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import Foundation
import SwiftUI
internal import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: CoinImageDataService
    private let coin: ExchangeModel
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: ExchangeModel) {
        self.coin = coin
        self.dataService = CoinImageDataService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
        }
    // функция запроса изображения
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
