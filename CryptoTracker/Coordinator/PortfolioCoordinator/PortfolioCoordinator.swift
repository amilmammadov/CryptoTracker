//
//  PortfolioCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

final class PortfolioCoordinator: ObservableObject {
    
    func start() -> some View {
        PortfolioCoordinatorView(portfolioCoordinator: self)
    }
    
    func createPortfolioViewModel() -> PortfolioViewModel {
        let portfolioViewModel = PortfolioViewModel()
        return portfolioViewModel
    }
}
