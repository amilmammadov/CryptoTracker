//
//  Date + ext.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 03.06.25.
//

import Foundation

extension Date {
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
