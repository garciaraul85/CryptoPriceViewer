//
//  Coin.swift
//  CryptoPriceViewer
//
//  Created by Saulo Garcia on 9/21/20.
//

import Foundation

struct Coin: Decodable {
    let name: String
    let price: String
}

struct CryptoDataContainer: Decodable {
    let status: String
    let data: CryptoData
    
}

struct CryptoData: Decodable {
    let coins: [Coin]
}
