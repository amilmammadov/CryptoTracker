//
//  HomeManager.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import Foundation
import Combine

final class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    private init(){}
    
    func getAllCoins() -> AnyPublisher<[CoinModel], Error> {
        guard let request = try? HomeEndPoints.getAllCoins().request() else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkManager.shared.fetch(model: [CoinModel].self, request: request)
    }
    
    func getGlobalMarketData() -> AnyPublisher<GlobalDataModel, Error> {
        guard let request = try? HomeEndPoints.getGlobalMarketData().request() else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkManager.shared.fetch(model: GlobalDataModel.self, request: request)
    }
}
