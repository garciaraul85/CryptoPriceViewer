//
//  ContentView.swift
//  CryptoPriceViewer
//
//  Created by Saulo Garcia on 9/21/20.
//

import SwiftUI
import Combine

struct CoinList: View {
    
    @ObservedObject
    private var viewModel = CoinListViewModel()
    
    var body: some View {
        NavigationView {
            // \.self = creates id for each item
            List(self.viewModel.coinViewModels, id: \.self) { coinViewModel in
                Text(coinViewModel.displayText)
            }.onAppear {
                self.viewModel.fetchCoins()
            }.navigationBarTitle("Coins")
        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinList()
    }
}
