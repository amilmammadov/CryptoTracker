//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 03.06.25.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startDate: Date
    private let endDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange: Double = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? ColorConstants.greenColor : ColorConstants.redColor
        
        endDate = coin.lastUpdated?.convertStringToDate() ?? Date()
        startDate = endDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack {
            chartView
                .background(
                    chartBackground
                )
                .overlay(chartAxis, alignment: .leading)
            HStack {
                Text(startDate.convertDateToString())
                Spacer()
                Text(endDate.convertDateToString())
            }
            .padding(.top, 4)
        }
        .font(.caption)
        .foregroundStyle(ColorConstants.secondaryTextColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 3.0)){
                    percentage = 1
                }
            }
        }
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: 0, y: 0))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 10, y:0)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x:0, y: 0)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x:0, y: 0)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x:0, y: 0)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviation())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviation())
            Spacer()
            Text(minY.formattedWithAbbreviation())
        }
    }
}

#Preview {
    ChartView(coin: PreviewData.coin)
}
