//
//  SettingsViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 02.06.25.
//

import Foundation

protocol SettingsViewModelProtocol: ObservableObject {
    func getUrl(_ url: AppUrl) -> URL?
}

enum AppUrl {
    case youtubeUrl, coinGeckoUrl, gitHubUrl, defaultUrl
}

final class SettingsViewModel: SettingsViewModelProtocol {
    private let youtubeUrl: String = "https://www.youtube.com/c/swiftfulthinking"
    private let coinGeckoUrl: String = "https://www.coingecko.com"  
    private let gitHubUrl: String = "https://github.com/amilmammadov"
    private let defaultUrl: String = "https://www.google.com"
    
    func getUrl(_ url: AppUrl) -> URL? {
        switch url {
        case .youtubeUrl:
            guard let url = URL(string: youtubeUrl) else { return nil }
            return url
        case .coinGeckoUrl:
            guard let url = URL(string: coinGeckoUrl) else { return nil }
            return url
        case .gitHubUrl:
            guard let url = URL(string: gitHubUrl) else { return nil }
            return url
        case .defaultUrl:
            guard let url = URL(string: defaultUrl) else { return nil }
            return url
        }
    }
}
