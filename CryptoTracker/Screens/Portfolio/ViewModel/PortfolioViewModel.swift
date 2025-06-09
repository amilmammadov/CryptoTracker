//
//  PortfolioViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import Foundation

protocol PortfolioViewModelProtocol: ObservableObject {
    var filteredCoins: [CoinModel] { get set }
    var portfolioCoins: [CoinModel] { get set }
    var searchText: String { get set }
    func setSubscribers()
    func updatePortfolio(coin: CoinModel, amount: Double)
}

final class PortfolioViewModel: BaseViewModel, PortfolioViewModelProtocol {
    
    func setSubscribers() {
        getAllCoins()
        setupSearchSubscriber()
        getSavedCoinsForPortfolio()
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        PortfolioDataManager.shared.updatePortfolio(coin: coin, amount: amount)
    }
}
