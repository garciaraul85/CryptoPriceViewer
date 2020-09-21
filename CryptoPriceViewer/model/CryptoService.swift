//
//  CryptoService.swift
//  CryptoPriceViewer
//
//  Created by Saulo Garcia on 9/21/20.
//

import Foundation
import Combine

final class CryptoService {
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coinranking.com"
        components.path = "/v1/public/coins"
        components.queryItems = [URLQueryItem(name: "base", value: "USD"), URLQueryItem(name: "timePeriod", value: "24h")]
        
        return components
    }
    
    func fetchCoins() -> AnyPublisher<CryptoDataContainer, Error> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: CryptoDataContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
