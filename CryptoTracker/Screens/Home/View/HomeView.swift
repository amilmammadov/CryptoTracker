//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import SwiftUI

struct HomeView<HomeViewModel: HomeViewModelProtocol>: View {
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var showSettingsView: Bool = false
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            ColorConstants.backgroundColor
                .ignoresSafeArea()
            
            if homeViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: ColorConstants.accentColor))
                    .controlSize(.large)
            }
            
            VStack {
                homeHeader
                StatisticsListView(homeViewModel: homeViewModel,showPortfolio: $showPortfolio)
                SearchBarView(searchText: $homeViewModel.searchText)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    ZStack {
                        if homeViewModel.portfolioCoins.isEmpty && homeViewModel.searchText.isEmpty {
                            emptyPortfolioText
                        } else {
                            portfolioList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                Spacer()
            }
            .refreshable {
                homeViewModel.setSubscribers()
            }
            .onAppear {
                homeViewModel.setSubscribers()
            }
            .onChange(of: homeViewModel.sortOption) { _ in
                if showPortfolio {
                    homeViewModel.getPortfolioCoins()
                }
            }
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(image: showPortfolio ? SystemImages.plus : SystemImages.info)
                .animation(.none, value: showPortfolio)
                .background {
                    CircleButtonAnimationView(animate: $showPortfolio)
                }
                .onTapGesture {
                    if showPortfolio {
                        homeViewModel.goToPortfolioView()
                    } else {
                        homeViewModel.goToSettingsView()
                    }
                }
            Spacer()
            Text(showPortfolio ? StringConstants.portfolio : StringConstants.livePrices)
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(ColorConstants.accentColor)
            Spacer()
            CircleButtonView(image: SystemImages.chevronRight)
                .rotationEffect(showPortfolio ? .degrees(180) : .degrees(0))
                .onTapGesture {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                }
        }
    }
}

extension HomeView {
    private var allCoinsList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(homeViewModel.filteredCoins) { coin in
                    CoinCellView(coin: coin, showHoldingsColumn: false)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            homeViewModel.goToCoinDetailView(coin)
                        }
                }
            }
        }
    }
    
    private var portfolioList: some View {
        ScrollView {
            LazyVStack {
                ForEach(homeViewModel.portfolioCoins) { coin in
                    CoinCellView(coin: coin, showHoldingsColumn: true)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            homeViewModel.goToCoinDetailView(coin)
                        }
                }
            }
        }
        .onAppear {
            homeViewModel.getPortfolioCoins()
        }
    }
    
    private var columnTitles: some View {
        HStack(spacing: 0){
            HStack(spacing: 4) {
                Text(StringConstants.coin)
                SystemImages.chevronDown
                    .opacity((homeViewModel.sortOption == .rank || homeViewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                homeViewModel.sortOption = homeViewModel.sortOption == .rank ? .rankReversed : .rank
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text(StringConstants.holdings)
                    SystemImages.chevronDown
                        .opacity((homeViewModel.sortOption == .holdings || homeViewModel.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: homeViewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    homeViewModel.sortOption = homeViewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
            HStack(spacing: 4) {
                Text(StringConstants.price)
                SystemImages.chevronDown
                    .opacity((homeViewModel.sortOption == .price || homeViewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                homeViewModel.sortOption = homeViewModel.sortOption == .price ? .priceReversed : .price
            }
        }
        .font(.caption)
        .foregroundStyle(ColorConstants.secondaryTextColor)
        .padding(.horizontal)
    }
    
    private var emptyPortfolioText: some View {
        Text(StringConstants.emptyPortfolioText)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(ColorConstants.accentColor)
            .multilineTextAlignment(.center)
            .padding(52)
    }
}

#Preview {
    NavigationStack {
        HomeView(homeViewModel: HomeViewModel())
    }
}
