//
//  PreviewData.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import Foundation

struct PreviewData {
    static let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 106802, marketCapRank: 1, marketCap: 107030,
        fullyDilutedValuation: 1,
        totalVolume: 2_124_825_395_132,
        high24H: 28_600_759_050,
        low24H: 109074,
        priceChange24H: -1874.343837574881,
        priceChangePercentage24H: -1.72109,
        marketCapChange24H: -37241739515.24365,
        marketCapChangePercentage24H: -1.72251,
        circulatingSupply: 19869575,
        totalSupply: 19869675,
        maxSupply: 21000000,
        ath: 111814,
        athChangePercentage: -4.439,
        athDate: "2025-05-22T18:41:28.492Z",
        atl: 67.81,
        atlChangePercentage: 157476.03822,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-05-25T16:46:43.142Z",
        sparklineIn7D: SparklineIn7D(
            price: [
                103879.27, 103917.67, 104358.79, 105248.97, 105489.05,
                105617.89, 105225.03, 104765.14, 103978.61, 104252.70,
                104348.16, 105427.48, 106139.68, 105437.01, 105096.52,
                104838.70, 103772.36, 103094.56, 102967.77, 102381.21,
                107008.50, 107111.61
            ]
        ),
        priceChangePercentage24HInCurrency: -1.721087755027011,
        currentHoldings: 1.5
    )
    
    static let stat1 = StatisticsModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    static let stat2 = StatisticsModel(title: "Total Volume", value: "$10.5Bn")
    static let stat3 = StatisticsModel(title: "Portfolio Value", value: "$12.5Bn", percentageChange: -65.34)
    
}

