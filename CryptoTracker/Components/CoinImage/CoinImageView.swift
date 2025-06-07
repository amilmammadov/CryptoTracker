//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 28.05.25.
//

import SwiftUI

struct CoinImageView: View {
    
    let coin: CoinModel
    @StateObject private var coinImageViewModel = CoinImageViewModel()
    
    var body: some View {
        ZStack {
            if let image = coinImageViewModel.image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            coinImageViewModel.downloadImage(path: coin.image ?? "", imageName: coin.id ?? "")
        }
    }
}

#Preview {
    CoinImageView(coin: PreviewData.coin)
}
