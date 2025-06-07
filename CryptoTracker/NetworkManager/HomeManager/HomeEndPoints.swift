//
//  HomeHelper.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import Foundation
import Combine

enum HomeEndPoints {
    case getAllCoins(path: String = "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
    case getGlobalMarketData(path: String = "global")
    
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
        case .getAllCoins(let path): return NetworkHelper.shared.configureUrl(path)
        case .getGlobalMarketData(path: let path): return NetworkHelper.shared.configureUrl(path)
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .getAllCoins: return HTTP.Methods.GET.rawValue
        case .getGlobalMarketData: return HTTP.Methods.GET.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .getAllCoins: return nil
        case .getGlobalMarketData: return nil
        }
    }
}

extension URLRequest {
    func addHeaders(_ endPoint: HomeEndPoints){
        switch endPoint {
        case .getAllCoins: break
        case .getGlobalMarketData: break
        }
    }
}
