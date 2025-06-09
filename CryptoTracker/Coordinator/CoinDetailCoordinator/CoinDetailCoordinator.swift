//
//  CoinDetailCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

final class CoinDetailCoordinator: ObservableObject {
    
    private var coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
    }
    
    func start() -> some View {
        CoinDetailCoordinatorView(coinDetailCoordinator: self)
    }
    
    func createCoinDetailViewModel() -> CoinDetailViewModel {
        let coinDetailViewModel = CoinDetailViewModel(coin: coin)
        return coinDetailViewModel
    }
}

