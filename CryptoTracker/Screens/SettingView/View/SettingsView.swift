//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 02.06.25.
//

import SwiftUI

struct SettingsView<SettingsViewModel: SettingsViewModelProtocol>: View {
    
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                swiftfulThinkingSection
                coingeckoSection
                developerSection
                applicationSection
            }
            .listStyle(.grouped)
            .navigationTitle(StringConstants.settings)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Images.logo
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(StringConstants.swiftfulThinkingSectionText)
                    .font(.callout)
                    .foregroundStyle(ColorConstants.accentColor)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            if let url = settingsViewModel.getUrl(.youtubeUrl) {
                Link(StringConstants.subscribeOnYoutube, destination: url)
                    .foregroundStyle(.blue)
            }
        } header: {
            Text(StringConstants.swiftfulThinkingHeader.uppercased())
        }
    }
    
    private var coingeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Images.coinGecko
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(StringConstants.coinGeckoSectionText)
                    .font(.callout)
                    .foregroundStyle(ColorConstants.accentColor)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            if let url = settingsViewModel.getUrl(.coinGeckoUrl) {
                Link(StringConstants.visitCoinGecko, destination: url)
                    .foregroundStyle(.blue)
            }
        } header: {
            Text(StringConstants.coinGeckoHeader.uppercased())
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Images.ownOne
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(StringConstants.developerSectionText)
                    .font(.callout)
                    .foregroundStyle(ColorConstants.accentColor)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            
            if let url = settingsViewModel.getUrl(.gitHubUrl) {
                Link(StringConstants.checkOutMyGithub, destination: url)
                    .foregroundStyle(.blue)
            }
        } header: {
            Text(StringConstants.developerHeader.uppercased())
        }
    }
    
    private var applicationSection: some View {
        Section {
            if let url = settingsViewModel.getUrl(.defaultUrl) {
                VStack(alignment: .leading) {
                    Link(StringConstants.termsOfService, destination: url)
                    Link(StringConstants.privacyPolicy, destination: url)
                    Link(StringConstants.companyWebsite, destination: url)
                    Link(StringConstants.learnMore, destination: url)
                }
                .foregroundStyle(.blue)
            }
        } header: {
            Text(StringConstants.learnMore)
        }
        
    }
}

#Preview {
    NavigationStack {
        SettingsView(settingsViewModel: SettingsViewModel())
    }
}
