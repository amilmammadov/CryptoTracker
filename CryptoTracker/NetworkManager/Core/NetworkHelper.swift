//
//  NetworkHelper.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import Foundation

final class NetworkHelper {
    static let shared = NetworkHelper()
    private init(){}
    
    private let baseUrl: String = "https://api.coingecko.com/api/v3/"
    
    func configureUrl(_ path: String) -> String {
        baseUrl + path
    }
}
