//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @State private var showLaunhScreen: Bool = true
    @StateObject private var launchCoordinator = LaunchCoordinator()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(ColorConstants.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(ColorConstants.accentColor)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppCoordinatorView()
                ZStack {
                    if showLaunhScreen {
                        LaunchCoordinatorView(launchCoordinator: launchCoordinator, showLaunchScreen: $showLaunhScreen)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2)
            }
        }
    }
}
