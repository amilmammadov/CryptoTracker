//
//  PortfolioViewCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

struct PortfolioCoordinatorView: View {
    
    @ObservedObject var portfolioCoordinator: PortfolioCoordinator
    @StateObject private var portfolioViewModel: PortfolioViewModel
    
    init(portfolioCoordinator: PortfolioCoordinator) {
        self.portfolioCoordinator = portfolioCoordinator
        _portfolioViewModel = StateObject(wrappedValue: portfolioCoordinator.createPortfolioViewModel())
    }
    
    var body: some View {
        PortfolioView(portfolioViewModel: portfolioViewModel)
    }
}
