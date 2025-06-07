//
//  NetworkError.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import Foundation

enum NetworkError:String, Error {
    case invalidUrl = "There is not exact match with your request!"
    case encodingError = "The problem occured when creating request!"
    case unableToComplete = "The problem occured with your request. Please check your network!"
    case invalidResponse = "Invalid response from server. Please try again!"
    case noContent = "There is not that kind of data!"
    case invalidImageData = "There is a problem when trying to download image!"
}
