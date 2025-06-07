//
//  StatisticsModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 30.05.25.
//

import Foundation

struct StatisticsModel: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
