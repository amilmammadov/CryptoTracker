//
//  UIApplication + Ext.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 30.05.25.
//

import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIApplication.shared.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
