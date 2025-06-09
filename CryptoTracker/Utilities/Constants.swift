//
//  Constants.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import SwiftUI

//MARK: - Color constants

struct ColorConstants {
    static let accentColor = Color("AccentColor")
    static let backgroundColor = Color("BackgroundColor")
    static let greenColor = Color("GreenColor")
    static let redColor = Color("RedColor")
    static let secondaryTextColor = Color("SecondaryTextColor")
    static let launchScreenBackgroundColor = Color("LaunchBackgroundColor")
    static let launchScreenAccentColor = Color("LaunchAccentColor")
}

//MARK: - String constants

struct StringConstants {
    static let portfolio = "Portfolio"
    static let livePrices = "Live Prices"
    static let coin = "Coin"
    static let holdings = "Holdings"
    static let price = "Price"
    static let searchBarPlaceHolder = "Search by name or symbol..."
    static let editProfile = "Edit Portfolio"
    static let marketCap = "Market Cap"
    static let volume24h = "24h Volume"
    static let btcDominance = "BTC Dominance"
    static let portfolioValue = "Portfolio Value"
    static let currentPriceOf = "Current price of"
    static let amountInYourPortfolio = "Amount in your portfolio:"
    static let amountInputPlaceholder = "Ex: 1.4"
    static let currentValue = "Current value:"
    static let save = "Save"
    static let settings = "Settings"
    static let swiftfulThinkingSectionText = "This app was made by following @SwiftFullthinking course on Youtube. It uses MVVM architecture, Combine and Core Data"
    static let subscribeOnYoutube = "Subscribe on Youtube"
    static let swiftfulThinkingHeader = "SwiftFul Thinking"
    static let coinGeckoSectionText = "The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed."
    static let visitCoinGecko = "Visit CoinGecko"
    static let coinGeckoHeader = "Coingecko"
    static let developerSectionText = "I'm Amil Mammadov, an aspiring iOS developer passionate about building clean, modern, and user-friendly apps with Swift and SwiftUI."
    static let checkOutMyGithub = "Check out my GitHub"
    static let developerHeader = "Developer"
    static let termsOfService = "Terms of Service"
    static let privacyPolicy = "Privacy Policy"
    static let companyWebsite = "Company Website"
    static let learnMore = "Learn More"
    static let application = "Application"
    static let launchScreenText = "Loading your portfolio..."
    static let overview = "Overview"
    static let additionalDetails = "Additional Details"
    static let readMore = "Read More..."
    static let showLess = "Show Less"
    static let website = "Website"
    static let reddit = "Reddit"
    static let emptyPortfolioText = "There is not any coin in portfolio. Tap the + button to get started!"
}

//MARK: - System images

struct SystemImages {
    static let info = Image(systemName: "info")
    static let plus = Image(systemName: "plus")
    static let chevronRight = Image(systemName: "chevron.right")
    static let dollar = Image(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
    static let magnifyingglass = Image(systemName: "magnifyingglass")
    static let xmarkFill = Image(systemName: "xmark.circle.fill")
    static let triangleFill = Image(systemName: "triangle.fill")
    static let xmark = Image(systemName: "xmark")
    static let checkMark = Image(systemName: "checkmark")
    static let chevronDown = Image(systemName: "chevron.down")
}

// MARK: - Local Images

struct Images {
    static let logo = Image("logo")
    static let coinGecko = Image("coingecko")
    static let ownOne = Image("ownone")
    static let launchImage = Image("logo-transparent")
}
