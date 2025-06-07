//
//  StatisticsView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 30.05.25.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: StatisticsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(ColorConstants.secondaryTextColor)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(ColorConstants.accentColor)
            
            HStack(spacing: 4) {
                SystemImages.triangleFill
                    .font(.caption2)
                    .rotationEffect((statistic.percentageChange ?? 0) >= 0 ? Angle(degrees: 0) : Angle(degrees: 180))
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((statistic.percentageChange ?? 0) >= 0 ? ColorConstants.greenColor : ColorConstants.redColor)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {
    Group {
        StatisticView(statistic: PreviewData.stat1)
        StatisticView(statistic: PreviewData.stat2)
        StatisticView(statistic: PreviewData.stat3)
    }
}
