//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 01.06.25.
//

import SwiftUI

struct CoinDetailView<CoinDetailVieModel: CoinDetailViewModelProtocol>: View {
    
    @State private var showMoreDescription: Bool = false
    @ObservedObject var coinDetailViewModel: CoinDetailVieModel

    var body: some View {
        ScrollView {
            ChartView(coin: coinDetailViewModel.coin)
                .frame(height: 150)
                .padding(.vertical)
            overviewTitle
            Divider()
            coinDescription
            overviewGrid
            additionalDetailTitle
            Divider()
            additionalDetailGrid
            websiteSection
        }
        .background(ColorConstants.backgroundColor)
        .scrollIndicators(.hidden)
        .padding()
        .onAppear(perform: {
            coinDetailViewModel.setSubscribers()
        })
        .navigationTitle(coinDetailViewModel.coin.id?.capitalized ?? "")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailing
            }
        }
        .alert(coinDetailViewModel.alertItem?.title ?? "Alert", isPresented: $coinDetailViewModel.isAlertShowing, actions: {
            Button(coinDetailViewModel.alertItem?.buttonTitle ?? "Ok", role: .cancel){}
        }, message: {
            Text(coinDetailViewModel.alertItem?.message ?? "")
        })
    }
}

extension CoinDetailView {
    private var navigationBarTrailing: some View {
        HStack {
            Spacer()
            Text(coinDetailViewModel.coin.symbol?.uppercased() ?? "")
            CoinImageView(coin: coinDetailViewModel.coin)
                .frame(width: 24, height: 24)
        }
        .foregroundStyle(ColorConstants.accentColor)
    }
    
    private var overviewTitle: some View {
        Text(StringConstants.overview)
            .font(.title)
            .bold()
            .foregroundStyle(ColorConstants.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: coinDetailViewModel.columns, alignment: .leading, spacing: 30) {
            ForEach(coinDetailViewModel.overviewStatistics) { statistics in
                StatisticView(statistic: statistics)
            }
        }
    }
    
    private var additionalDetailTitle: some View {
        Text(StringConstants.additionalDetails)
            .font(.title)
            .bold()
            .foregroundStyle(ColorConstants.accentColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalDetailGrid: some View {
        LazyVGrid(columns: coinDetailViewModel.columns, alignment: .leading, spacing: 30) {
            ForEach(coinDetailViewModel.additionalStatistics) { statistics in
                StatisticView(statistic: statistics)
            }
        }
    }
    
    private var coinDescription: some View {
        ZStack {
            VStack(alignment: .leading) {
                if let coinDescription = coinDetailViewModel.coinDetail?.description?.en {
                    Text(coinDescription)
                        .lineLimit(showMoreDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(ColorConstants.secondaryTextColor)
                    Button {
                        withAnimation(showMoreDescription ? .easeIn : .easeOut){
                            showMoreDescription = showMoreDescription == true ? false : true
                        }
                    } label: {
                        Text(showMoreDescription ? StringConstants.showLess : StringConstants.readMore)
                            .bold()
                            .font(.caption)
                            .padding(.vertical, 4)
                    }
                    .foregroundStyle(.blue)
                }
            }
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading) {
            if let websitePath = coinDetailViewModel.coinDetail?.links?.homepage?.first,
               let url = URL(string: websitePath){
                Link(StringConstants.website, destination: url)
            }
            if let subredditPath = coinDetailViewModel.coinDetail?.links?.subredditUrl,
               let url = URL(string: subredditPath){
                Link(StringConstants.reddit, destination: url)
            }
        }
        .foregroundStyle(.blue)
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        CoinDetailView(coinDetailViewModel: CoinDetailViewModel(coin: PreviewData.coin))
    }
}
