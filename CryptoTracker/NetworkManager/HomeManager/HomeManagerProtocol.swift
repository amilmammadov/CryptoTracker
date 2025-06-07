//
//  HomeManagerProtocol.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import Foundation
import Combine

protocol HomeManagerProtocol {
    func getAllCoins() -> AnyPublisher<[CoinModel], Error>
    func getGlobalMarketData() -> AnyPublisher<GlobalDataModel, Error>
}
