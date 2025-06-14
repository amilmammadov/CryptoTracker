//
//  NetworkErrorHandler.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 14.06.25.
//

import Foundation

final class NetworkErrorHandler {
    static let shared = NetworkErrorHandler()
    private init(){}
    
    func handleError(_ error: Error) -> AlertItem {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidUrl:
                return AlertContext.invalidUrl
            case .encodingError:
                return AlertContext.encodingError
            case .invalidResponse:
                return AlertContext.invalidResponse
            case .unableToComplete:
                return AlertContext.unableToComplete
            case .noContent:
                return AlertContext.noContent
            case .invalidImageData:
                return AlertContext.invalidImageData
            }
        } else {
            return AlertContext.unableToComplete
        }
    }
}
