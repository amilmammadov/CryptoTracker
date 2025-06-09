//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 31.05.25.
//

import SwiftUI

struct PortfolioView<PortfolioViewModel: PortfolioViewModelProtocol>: View {
    
    @ObservedObject var portfolioViewModel: PortfolioViewModel
    @State private var selectedCoin: CoinModel?
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    SearchBarView(searchText: $portfolioViewModel.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(ColorConstants.backgroundColor)
            .navigationTitle(StringConstants.editProfile)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavigationBarButtons
                }
            }
            .onAppear {
                portfolioViewModel.setSubscribers()
            }
        }
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(portfolioViewModel.searchText.isEmpty ? portfolioViewModel.portfolioCoins : portfolioViewModel.filteredCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 76)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedCoin?.id == coin.id ? ColorConstants.greenColor : Color.clear, lineWidth: 1)
                        }
                }
            }
        }
        .padding(.vertical, 4)
        .padding(.leading)
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        if let portfolioCoin = portfolioViewModel.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("\(StringConstants.currentPriceOf) \(selectedCoin?.symbol?.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice?.asCurrenyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text(StringConstants.amountInYourPortfolio)
                    .lineLimit(1)
                Spacer()
                TextField(StringConstants.amountInputPlaceholder, text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text(StringConstants.currentValue)
                Spacer()
                Text(getCurrentValue().asCurrenyWith2Decimals())
            }
        }
        .animation(.none, value: selectedCoin)
        .font(.headline)
        .padding()
    }
    
    private var trailingNavigationBarButtons: some View {
        HStack(spacing: 12) {
            SystemImages.checkMark
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text(StringConstants.save.uppercased())
            }
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double{
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0.0)
        }
        return 0
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin,
              let amount = Double(quantityText) else { return }
        portfolioViewModel.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelection()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelection(){
        selectedCoin = nil
        portfolioViewModel.searchText = ""
    }
}
 
#Preview {
    PortfolioView(portfolioViewModel: PortfolioViewModel())
}
