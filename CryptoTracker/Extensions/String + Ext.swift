//
//  Date + Ext.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 03.06.25.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self) ?? Date()
    }
}
