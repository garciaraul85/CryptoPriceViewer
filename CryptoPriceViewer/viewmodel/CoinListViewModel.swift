//
//  CoinListViewModel.swift
//  CryptoPriceViewer
//
//  Created by Saulo Garcia on 9/21/20.
//
import Combine
import Combine

class CoinListViewModel: ObservableObject {
    
    private let cryptoService = CryptoService()
    
    // @Published So SwiftUI reacts to changes
    @Published var coinViewModels = [CoinViewModel]()
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = cryptoService.fetchCoins().sink(receiveCompletion: { _ in
            
        }, receiveValue: { cryptoContainer in
            self.coinViewModels = cryptoContainer.data.coins.map{ CoinViewModel(coin: $0) }
        })
    }
    
}

struct CoinViewModel {
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        return coin.price
    }
    
}
