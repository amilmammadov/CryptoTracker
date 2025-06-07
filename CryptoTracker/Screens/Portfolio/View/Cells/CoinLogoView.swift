//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 31.05.25.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 52, height: 52)
                .padding(.bottom, 4)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .foregroundStyle(ColorConstants.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.id?.capitalized ?? "")
                .font(.caption)
                .foregroundStyle(ColorConstants.secondaryTextColor)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: PreviewData.coin)
}
