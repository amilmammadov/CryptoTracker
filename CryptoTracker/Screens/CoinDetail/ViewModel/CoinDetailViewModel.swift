//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 01.06.25.
//

import Combine
import SwiftUI

protocol CoinDetailViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var coin: CoinModel { get set }
    var coinDetail: CoinDetailModel? { get set }
    var overviewStatistics: [StatisticsModel] { get set }
    var additionalStatistics: [StatisticsModel] { get set }
    var columns: [GridItem] { get set }
    var isAlertShowing: Bool { get set }
    var alertItem: AlertItem? { get set }
    func setSubscribers()
}

final class CoinDetailViewModel: CoinDetailViewModelProtocol {
    
    @Published var isLoading: Bool = true
    @Published var coin: CoinModel
    @Published var coinDetail: CoinDetailModel?
    @Published var overviewStatistics: [StatisticsModel] = []
    @Published var additionalStatistics: [StatisticsModel] = []
    @Published var isAlertShowing: Bool = false
    @Published var alertItem: AlertItem?
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    private var cancelables: Set<AnyCancellable> = []
    
    init(coin: CoinModel){
        self.coin = coin
    }
    
    func setSubscribers(){
        getCoinDetail()
        createReadableCoinDetailForDetailView()
    }
    
    //MARK: - Fetch coin detail by coin id
    private func getCoinDetail(){
        CoinDetailManager.shared.getCoinDetail(coinId: coin.id ?? "")
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isAlertShowing = true
                    self.alertItem = NetworkErrorHandler.shared.handleError(error)
                }
            } receiveValue: { [weak self] coinDetail in
                guard let self else { return }
                self.coinDetail = coinDetail
            }
            .store(in: &cancelables)
    }
    
    //MARK: - Configure coinDetail to show as readable format on coin's detail view
    private func createReadableCoinDetailForDetailView(){
        $coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] result in
                guard let self else { return }
                self.overviewStatistics = result.overview
                self.additionalStatistics = result.additional
            }
            .store(in: &cancelables)
    }
    
    private func mapDataToStatistics(coinDetail: CoinDetailModel?, coin: CoinModel) -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
        let overviewArray: [StatisticsModel] = createOverviewArray(coin: coin)
        let additionalArray: [StatisticsModel] = createAdditionalArray(coinDetail: coinDetail, coin: coin)
        return (overviewArray, additionalArray)
    }
    
    //MARK: - Create Overview data
    private func createOverviewArray(coin: CoinModel) -> [StatisticsModel] {
        let price: String = coin.currentPrice?.asCurrenyWith6Decimals() ?? ""
        let priceChange: Double = coin.priceChangePercentage24H ?? 0
        let priceStatistics: StatisticsModel = StatisticsModel(title: "Coin Price", value: price, percentageChange: priceChange)
        
        let marketCap: String = "$" + (coin.marketCap?.formattedWithAbbreviation() ?? "")
        let marketCapChange: Double = coin.marketCapChangePercentage24H ?? 0
        let marketCapStatistics: StatisticsModel = StatisticsModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapChange)
        
        let rank: String = "\(coin.rank)"
        let rankStatistics: StatisticsModel = StatisticsModel(title: "Rank", value: rank)
        
        let volume: String = "$" + (coin.totalVolume?.formattedWithAbbreviation() ?? "")
        let volumeStatistics: StatisticsModel = StatisticsModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticsModel] = [
            priceStatistics,
            marketCapStatistics,
            rankStatistics,
            volumeStatistics
        ]
        return overviewArray
    }
    
    //MARK: - Create Additional detail for coin
    private func createAdditionalArray(coinDetail: CoinDetailModel?, coin: CoinModel) -> [StatisticsModel] {
        let high: String = coin.high24H?.asCurrenyWith2Decimals() ?? "n/a"
        let highStatistics: StatisticsModel = StatisticsModel(title: "24h High", value: high)
        
        let low: String = coin.low24H?.asCurrenyWith6Decimals() ?? "n/a"
        let lowStatistics: StatisticsModel = StatisticsModel(title: "24h Low", value: low)
        
        let priceChange: String = coin.priceChange24H?.asCurrenyWith2Decimals() ?? "n/a"
        let pricePercentageChange: Double = coin.priceChangePercentage24H ?? 0
        let pricePercentageStatistics: StatisticsModel = StatisticsModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentageChange)
        
        let marketCapChange: String = "$" + (coin.marketCapChange24H?.formattedWithAbbreviation() ?? "")
        let marketCapPercentageChange: Double = coin.marketCapChangePercentage24H ?? 0
        let marketCapPercentageStatistics:StatisticsModel = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentageChange)
        
        let blockTime: Int = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString: String = "\(blockTime)"
        let blockTimeStatistics: StatisticsModel = StatisticsModel(title: "Block Time", value: blockTimeString)
        
        let hashing: String = coinDetail?.hashingAlgorithm ?? ""
        let hashingStatistics: StatisticsModel = StatisticsModel(title: "Hashing Algoritm", value: hashing)
        
        let additionalArray: [StatisticsModel] = [
            highStatistics,
            lowStatistics,
            pricePercentageStatistics,
            marketCapPercentageStatistics,
            blockTimeStatistics,
            hashingStatistics
        ]
        return additionalArray
    }
}



