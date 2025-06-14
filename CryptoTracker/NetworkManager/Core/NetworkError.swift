//
//  NetworkError.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import SwiftUI

enum NetworkError: Error {
    case invalidUrl
    case encodingError
    case unableToComplete
    case invalidResponse
    case noContent
    case invalidImageData 
}

struct AlertItem {
    let title: String
    let message: String
    let buttonTitle: String
}

struct AlertContext {
    static let invalidUrl = AlertItem(title: "Server Error!", message: "There is an issue connecting to server. Please contact with support!", buttonTitle: "Ok")
    static let encodingError = AlertItem(title: "Server Error!", message: "The problem occured when creating request!", buttonTitle: "Ok")
    static let unableToComplete = AlertItem(title: "Server Error!", message: "There is an problem. Please check your internet connection!", buttonTitle: "Ok")
    static let invalidResponse = AlertItem(title: "Server Error!", message: "There is a problem. Please contact with support!", buttonTitle: "Ok")
    static let noContent = AlertItem(title: "No Content!", message: "There is not content!", buttonTitle: "Ok")
    static let invalidImageData = AlertItem(title: "Server Error!", message: "There is a problem when trying to download image!", buttonTitle: "Ok")
}
