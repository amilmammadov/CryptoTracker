//
//  CoinDetailCoordinatorView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

struct CoinDetailCoordinatorView: View {
    
    @ObservedObject var coinDetailCoordinator: CoinDetailCoordinator
    @StateObject private var coinDetailViewModel: CoinDetailViewModel
    
    init(coinDetailCoordinator: CoinDetailCoordinator) {
        self.coinDetailCoordinator = coinDetailCoordinator
        _coinDetailViewModel = StateObject(wrappedValue: coinDetailCoordinator.createCoinDetailViewModel())
    }
    
    var body: some View {
        CoinDetailView(coinDetailViewModel: coinDetailViewModel)
    }
}
