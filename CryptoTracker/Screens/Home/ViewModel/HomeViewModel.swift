//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.


import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var allCoins: [CoinModel] { get set }
    var filteredCoins: [CoinModel] { get set }
    var portfolioCoins: [CoinModel] { get set }
    var isLoading: Bool { get set }
    var searchText: String { get set }
    var statistics: [StatisticsModel] { get set }
    var marketData: MarketDataModel? { get set }
    var sortOption: SortOption { get set }
    var alertItem: AlertItem? { get set }
    var isAlertShowing: Bool { get set }
    func setSubscribers()
    func getPortfolioCoins()
    func goToSettingsView()
    func goToPortfolioView()
    func goToCoinDetailView(_ coin: CoinModel)
}

enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price,  priceReversed
}

final class HomeViewModel: BaseViewModel, HomeViewModelProtocol {
    
    @Published var statistics: [StatisticsModel] = []
    var coordinator: HomeCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    func setSubscribers(){
        getAllCoins()
        setupSearchSubscriber()
        setupSortSubscriberForAllCoins()
        getGlobalMarketData()
        getSavedCoinsForPortfolio()
        getMarketDataForStatistics()
        getPortfolioCoins()
    }
    
    //MARK: - Setup sort subscriber to get sorted coins when sortOption changes
    private func setupSortSubscriberForAllCoins(){
        $sortOption
            .combineLatest($filteredCoins)
            .map(sortCoins)
            .sink { [weak self] coins in
                guard let self else { return }
                self.filteredCoins = coins
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Configure market data and portfolio coins for statistics
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
    
    //MARK: - Map marketData and portfolioCoins to Statistics array
    private func mapMarketDataAndPortfolioEntities(_ marketData: MarketDataModel?, _ portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        guard let marketData else { return [] }
        var statistics = [StatisticsModel]()
        let marketCapStatistics = StatisticsModel(title: StringConstants.marketCap, value: marketData.marketCap, percentageChange: marketData.marketCapChangePercentage24HUsd)
        let volumeStatistics = StatisticsModel(title: StringConstants.volume24h, value: marketData.volume)
        let bitcoinDominanceStatistics = StatisticsModel(title: StringConstants.btcDominance, value: marketData.bitcoinDominance)
        
        //MARK: - Calculate portfolioValue and percentageChange for Portfolio
        
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
    
    //MARK: - Sort home page coins when tapped column's title
    private func sortCoins(_ sortOption: SortOption, _ coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .rank, .holdings:
            return coins.sorted(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            return coins.sorted(by: { $0.rank > $1.rank })
        case .price:
            return coins.sorted(by: { $0.currentPrice ?? 0 < $1.currentPrice ?? 0 })
        case .priceReversed:
            return coins.sorted(by: { $0.currentPrice ?? 0 > $1.currentPrice ?? 0 })
        }
    }
    
    //MARK: - Get saved portfolio coins
    func getPortfolioCoins(){
        PortfolioDataManager.shared.getPortfolio()
    }
    
    func goToSettingsView(){
        coordinator?.present(.settings)
    }
    
    func goToCoinDetailView(_ coin: CoinModel){
        coordinator?.goToCoinDetail(.coinDetail(coin: coin))
    }
    
    func goToPortfolioView(){
        coordinator?.present(.portfolio)
    }
}
