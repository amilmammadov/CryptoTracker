//
//  StatisticsListView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 30.05.25.
//

import SwiftUI

struct StatisticsListView<HomeViewModel: HomeViewModelProtocol>: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(homeViewModel.statistics) { statistic in
                StatisticView(statistic: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    StatisticsListView(homeViewModel: HomeViewModel(), showPortfolio: .constant(false))
}
