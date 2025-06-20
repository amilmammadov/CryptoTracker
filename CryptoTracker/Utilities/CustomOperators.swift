//
//  CustomOperators.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 30.05.25.
//

import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T>{
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
