//
//  LaunchCoordinatorView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

struct LaunchCoordinatorView: View {
    
    @ObservedObject var launchCoordinator: LaunchCoordinator
    @StateObject private var launchViewModel: LaunchViewModel
    @Binding var showLaunchScreen: Bool
    
    init(launchCoordinator: LaunchCoordinator, showLaunchScreen: Binding<Bool>) {
        self.launchCoordinator = launchCoordinator
        _launchViewModel = StateObject(wrappedValue: launchCoordinator.createLaunchViewModel())
        self._showLaunchScreen = showLaunchScreen
    }
    
    var body: some View {
        LaunchView(launchViewModel: launchViewModel, showLuanchScreen: $showLaunchScreen)
    }
}
