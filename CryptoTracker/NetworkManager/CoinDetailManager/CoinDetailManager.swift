//
//  CoinDetailManager.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 01.06.25.
//

import SwiftUI
import Combine

final class CoinDetailManager: CoinDetailManagerProtocol {
    static let shared = CoinDetailManager()
    private init(){}
    
    func getCoinDetail(coinId: String) -> AnyPublisher<CoinDetailModel, Error> {
        guard let request = try? CoinDetailEndPoints.getCoinDetail(coindId: coinId).request() else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return NetworkManager.shared.fetch(model: CoinDetailModel.self, request: request)
    }
}
