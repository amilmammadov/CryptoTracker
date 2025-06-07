//
//  CoinDetailModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 01.06.25.
//

import Foundation

struct CoinDetailModel: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
}

struct Description: Codable {
    let en: String?
}

struct Links: Codable {
    let homepage: [String]?
    let subredditUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditUrl = "subreddit_url"
    }
}
