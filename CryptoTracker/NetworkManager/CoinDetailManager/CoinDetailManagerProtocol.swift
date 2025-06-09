//
//  CoinDetailManagerProtocol.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 01.06.25.
//

import Combine

protocol CoinDetailManagerProtocol {
    func getCoinDetail(coinId: String) -> AnyPublisher<CoinDetailModel, Error>
}
