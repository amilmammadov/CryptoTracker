//
//  CoinCell.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import SwiftUI

struct CoinCellView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .padding(.trailing)
    }
}

extension CoinCellView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.marketCapRank ?? 0)")
                .font(.caption)
                .foregroundStyle(ColorConstants.secondaryTextColor)
                .frame(minWidth: 32)
            CoinImageView(coin: coin)
                .frame(width: 32, height: 32)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .foregroundStyle(ColorConstants.accentColor)
                .padding(.leading, 6)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrenyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(ColorConstants.accentColor)
        .padding(.trailing, 8)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice?.asCurrenyWith6Decimals() ?? "")
                .bold()
                .foregroundStyle(ColorConstants.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    coin.priceChangePercentage24H ?? 0 >= 0 ?
                    ColorConstants.greenColor :
                    ColorConstants.redColor
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

#Preview {
    CoinCellView(coin: PreviewData.coin, showHoldingsColumn: false)
}
