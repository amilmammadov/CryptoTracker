//
//  BaseViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var filteredCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    @Published var marketData: MarketDataModel?
    @Published var sortOption: SortOption = .rank
    @Published var alertItem: AlertItem?
    @Published var isAlertShowing: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Fetch all coins
    func getAllCoins() {
        HomeManager.shared.getAllCoins()
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isAlertShowing = true
                    self.alertItem = NetworkErrorHandler.shared.handleError(error)
                }
            } receiveValue: { [weak self] coins in
                guard let self else { return }
                self.allCoins = coins
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Setup search subscriber to get filtered coins when searchText changes
    func setupSearchSubscriber() {
        $searchText
            .combineLatest($allCoins)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.filteredCoins = coins
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Filter coins by name, symbol and id
    func filterCoins(_ text: String, _ coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            (coin.name?.lowercased().contains(lowercasedText) ?? false) ||
            (coin.symbol?.lowercased().contains(lowercasedText) ?? false) ||
            (coin.id?.lowercased().contains(lowercasedText) ?? false)
        }
    }
    
    //MARK: - Fetch marketData to create statistics data
    func getGlobalMarketData(){
        HomeManager.shared.getGlobalMarketData()
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .finished:
                    self.isLoading = false
                    print("DEBUG: Data had fetched")
                case .failure(let error):
                    self.isAlertShowing = true
                    self.alertItem = NetworkErrorHandler.shared.handleError(error)
                }
            } receiveValue: { [weak self] globalData in
                guard let self else { return }
                self.marketData = globalData.data
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Get saved portfolio coins
    func getSavedCoinsForPortfolio(){
        $allCoins
            .combineLatest(PortfolioDataManager.shared.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] portfolioCoins in
                guard let self else { return }
                self.portfolioCoins = sortPortfolioCoinsIfNeeded(portfolioCoins)
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Configure portfolio coins with current holdigs
    private func mapAllCoinsToPortfolioCoins(_ allCoins: [CoinModel], _ portfolioEntities: [PortfolioEntity]) -> [CoinModel]{
        return allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinId == coin.id }) else { return nil }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    //MARK: - Sort portfolio coins when tapped column's title
    private func sortPortfolioCoinsIfNeeded(_ coins: [CoinModel]) -> [CoinModel]{
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .rank:
            return  coins.sorted(by: { $0.rank < $1.rank })
        case .rankReversed:
            return coins.sorted(by: { $0.rank > $1.rank })
        case .price:
            return coins.sorted(by: { $0.currentPrice ?? 0 < $1.currentPrice ?? 0 })
        case .priceReversed:
            return coins.sorted(by: { $0.currentPrice ?? 0 > $1.currentPrice ?? 0 })
        }
    }
}

