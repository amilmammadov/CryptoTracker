//
//  HomeCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 08.06.25.
//

import SwiftUI

final class HomeCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    
    enum Page: Hashable {
        case coinDetail(coin: CoinModel)
    }
    
    enum Sheet: String, Identifiable {
        case settings
        case portfolio
        var id: String { self.rawValue }
    }
    
    func start() -> some View {
        HomeCoordinatorView(homeCoordinator: self)
    }
    
    func createHomeViewModel() -> HomeViewModel {
        let homeViewModel = HomeViewModel()
        homeViewModel.coordinator = self
        return homeViewModel
    }
    
    func present(_ sheet: Sheet){
        self.sheet = sheet
    }
    
    func goToCoinDetail(_ page: Page){
        path.append(page)
    }
}

