//
//  NetworkManager.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import Foundation
internal import Combine

class NetworkManager {
    
    static func downLoad(request: URLRequest) -> AnyPublisher<Data, any Error> {
      return URLSession.shared.dataTaskPublisher(for: request)  // отправляет запрос в сеть и получает ответ
            .subscribe(on: DispatchQueue.global(qos: .utility)) // переводим дальнейшую работу в фоновый поток
            .tryMap { output -> Data in                         // проверяем валидный ли респонс и статус код
                
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main) // переводим полученые данные на главный поток
            .eraseToAnyPublisher()           // позволяет работать с любым типом паблишера, создает дженерик тип
    }
    
    static func handleComplition(completion: Subscribers.Completion<any Error>) { // функция обрабатывает ответ сервера
        switch completion {
        case .finished:
            break
            case .failure(let error):
            print("Ошибка - \(error.localizedDescription)")
        }
    }
    
}
