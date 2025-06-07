//
//  CoinDetailEndPoints.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 01.06.25.
//

import Foundation

enum CoinDetailEndPoints {
    case getCoinDetail(path: String = "coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
    
    func request() throws -> URLRequest {
        guard let url = URL(string: self.path) else {
            throw NetworkError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.addHeaders(self)
        return request
    }
    
    private var path: String {
        switch self {
        case .getCoinDetail(let path): return NetworkHelper.shared.configureUrl(path)
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .getCoinDetail: return HTTP.Methods.GET.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .getCoinDetail: return nil
        }
    }
}

extension URLRequest {
    func addHeaders(_ endPoint: CoinDetailEndPoints){
        switch endPoint {
        case .getCoinDetail: break
        }
    }
}
