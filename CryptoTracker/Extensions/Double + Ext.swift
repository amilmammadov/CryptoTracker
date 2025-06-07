//
//  Double + Ext.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import Foundation

extension Double {
    
    // Converts double into curreny with 2 decimal places
    /// ```
    /// 1234.56 - $1,234.56
    /// ```
    
    private var currencyFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    /// Converts double into curreny as a String with 2 decimal places
    /// ```
    /// 1234.56 - "$1,234.56"
    /// ```
    
    func asCurrenyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts double into curreny with 2 - 6 decimal places
    /// ```
    /// 1234.56 - $1,234.56
    /// 1.23456 - $1.23456
    /// ```
    
    private var currencyFormatter6: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 6
        return numberFormatter
    }
    
    /// Converts double into curreny as a String with 2 - 6 decimal places
    /// ```
    /// 1234.56 - "$1,234.56"
    /// 1.23456 - "$1.23456"
    /// ```
    
    func asCurrenyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts double into string representation
    /// ```
    /// 1.23456 - "$1.23"
    /// ```
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts double into string representation with % sign
    /// ```
    /// 1.23456 - "$1.23%"
    /// ```
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    /// Converts double to T B M ...
    
    func formattedWithAbbreviation() -> String {
        let num = abs(self)
        let sign = self < 0 ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            return "\(sign)\((num / 1_000_000_000_000).rounded(toPlaces: 2)) T"
        case 1_000_000_000...:
            return "\(sign)\((num / 1_000_000_000).rounded(toPlaces: 2)) B"
        case 1_000_000...:
            return "\(sign)\((num / 1_000_000).rounded(toPlaces: 2)) M"
        case 1_000...:
            return "\(sign)\((num / 1_000).rounded(toPlaces: 2)) BİN"
        default:
            return "\(sign)\(self.rounded(toPlaces: 2))"
        }
    }
    
    func rounded(toPlaces places: Int) -> String {
        String(format: "%.\(places)f", self)
    }
}
