//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var showLaunhScreen: Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(ColorConstants.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(ColorConstants.accentColor)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                }
                .navigationViewStyle(.stack)
                .toolbar(.hidden, for: .navigationBar)
                .environmentObject(homeViewModel)
                
                ZStack {
                    if showLaunhScreen {
                        LaunchView(showLuanchScreen: $showLaunhScreen)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2)
            }
        }
    }
}
