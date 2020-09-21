//
//  CoinListViewModel.swift
//  CryptoPriceViewer
//
//  Created by Saulo Garcia on 9/21/20.
//
import Combine
import Foundation

class CoinListViewModel: ObservableObject {
    
    private let cryptoService = CryptoService()
    
    // @Published So SwiftUI reacts to changes
    @Published var coinViewModels = [CoinViewModel]()
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = cryptoService.fetchCoins().sink(receiveCompletion: { _ in
            
        }, receiveValue: { cryptoContainer in
            self.coinViewModels = cryptoContainer.data.coins.map{ CoinViewModel(coin: $0) }
            print(self.coinViewModels)
        })
    }
    
}

struct CoinViewModel: Hashable {
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        guard let price = Double(coin.price),
              let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) else {
            return ""
        }
    
        return formattedPrice
    }
    
    var displayText: String {
        return "\(name) - \(formattedPrice)"
    }
    
}
