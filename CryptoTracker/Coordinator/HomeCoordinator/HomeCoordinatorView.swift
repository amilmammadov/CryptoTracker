//
//  HomeCoordinatorView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 08.06.25.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject var homeCoordinator: HomeCoordinator
    @StateObject private var homeViewModel: HomeViewModel
    
    init(homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator
        _homeViewModel = StateObject(wrappedValue: homeCoordinator.createHomeViewModel())
    }

    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView(homeViewModel: homeViewModel)
                .navigationDestination(for: HomeCoordinator.Page.self){ page in
                    switch page {
                    case .coinDetail(let coin):
                        let coinDetailCoordinator = CoinDetailCoordinator(coin: coin)
                        coinDetailCoordinator.start()
                    }
                }
                .sheet(item: $homeCoordinator.sheet) { sheet in
                    switch sheet {
                    case .settings:
                        let settingsCoordinator = SettingsCoordinator()
                        settingsCoordinator.start()
                    case .portfolio:
                        let portfolioCoordinator = PortfolioCoordinator()
                        portfolioCoordinator.start()
                    }
                }
        }
        .navigationViewStyle(.stack)
        .toolbar(.hidden, for: .navigationBar)
    }
}
