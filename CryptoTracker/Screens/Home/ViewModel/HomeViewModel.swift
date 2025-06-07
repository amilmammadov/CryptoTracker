//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.


import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var filteredCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    @Published var statistics: [StatisticsModel] = []
    @Published var marketData: MarketDataModel?
    @Published var sortOption: SortOption = .holdings
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price,  priceReversed
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func setSubscribers(){
        getAllCoins()
        setupSearchSubscriber()
        getGlobalMarketData()
        getSavedCoinsForPortfolio()
        getMarketDataForStatistics()
    }
    
    private func getAllCoins() {
        HomeManager.shared.getAllCoins()
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("DEBUG: Error \(error)")
                }
            } receiveValue: { [weak self] coins in
                guard let self else { return }
                self.allCoins = coins
            }
            .store(in: &cancellables)
    }
    
    private func setupSearchSubscriber() {
        $searchText
            .combineLatest($allCoins, $sortOption)
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] coins in
                self?.filteredCoins = coins
            }
            .store(in: &cancellables)
    }
    
    private func getGlobalMarketData(){
        HomeManager.shared.getGlobalMarketData()
            .sink { result in
                switch result {
                case .finished:
                    print("DEBUG: Data had fetched")
                case .failure(let error):
                    print("DEBUG: Error \(error)")
                }
            } receiveValue: { [weak self] globalData in
                guard let self else { return }
                self.marketData = globalData.data
            }
            .store(in: &cancellables)
    }
    
    private func getSavedCoinsForPortfolio(){
        $allCoins
            .combineLatest(PortfolioDataManager.shared.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] portfolioCoins in
                guard let self else { return }
                self.portfolioCoins = sortPortfolioCoinsIfNeeded(portfolioCoins)
            }
            .store(in: &cancellables)
    }
    
    private func getMarketDataForStatistics(){
        $marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketDataAndPortfolioEntities)
            .sink { [weak self] statisticsData in
                guard let self else { return }
                self.statistics = statisticsData
            }
            .store(in: &cancellables)
    }
    
    private func mapMarketDataAndPortfolioEntities(_ marketData: MarketDataModel?, _ portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        guard let marketData else { return [] }
        var statistics = [StatisticsModel]()
        let marketCapStatistics = StatisticsModel(title: StringConstants.marketCap, value: marketData.marketCap, percentageChange: marketData.marketCapChangePercentage24HUsd)
        let volumeStatistics = StatisticsModel(title: StringConstants.volume24h, value: marketData.volume)
        let bitcoinDominanceStatistics = StatisticsModel(title: StringConstants.btcDominance, value: marketData.bitcoinDominance)
        
        //MARK: - calculate portfolioValue and percentageChange for Portfolio
        
        let portfolioValue = portfolioCoins.map{ $0.currentHoldingsValue }.reduce(0, +)
        let previousValue = portfolioCoins.map { coin in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0.0) / 100
            return currentValue / (1 + percentChange)
        }.reduce(0.0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolioStatistics = StatisticsModel(title: StringConstants.portfolio, value: portfolioValue.formattedWithAbbreviation(), percentageChange: percentageChange)
        
        statistics.append(contentsOf: [
            marketCapStatistics,
            volumeStatistics,
            bitcoinDominanceStatistics,
            portfolioStatistics
        ])
        return statistics
    }
    
    private func filterAndSortCoins(_ searchedText: String, _ coins: [CoinModel], _ sortOption: SortOption) -> [CoinModel]{
        var updatedCoins = filterCoins(searchedText, coins)
        sortCoins(sortOption, &updatedCoins)
        return updatedCoins
    }
    
    private func filterCoins(_ text: String, _ coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            (coin.name?.lowercased().contains(lowercasedText) ?? false) ||
            (coin.symbol?.lowercased().contains(lowercasedText) ?? false) ||
            (coin.id?.lowercased().contains(lowercasedText) ?? false)
        }
    }
    
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
    
    private func sortCoins(_ sortOption: SortOption, _ coins: inout [CoinModel]){
        switch sortOption {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice ?? 0 < $1.currentPrice ?? 0 })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice ?? 0 > $1.currentPrice ?? 0 })
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(_ allCoins: [CoinModel], _ portfolioEntities: [PortfolioEntity]) -> [CoinModel]{
        return allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinId == coin.id }) else { return nil }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        PortfolioDataManager.shared.updatePortfolio(coin: coin, amount: amount)
    }
    
    func getPortfolioCoins(){
        PortfolioDataManager.shared.getPortfolio()
    }
}
