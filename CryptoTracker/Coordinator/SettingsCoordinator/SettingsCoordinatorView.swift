//
//  SettingsCoordinatorView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

struct SettingsCoordinatorView: View {
    
    @ObservedObject var settingsCoordinator: SettingsCoordinator
    @StateObject private var settingsViewModel: SettingsViewModel
    
    init(settingsCoordinator: SettingsCoordinator) {
        self.settingsCoordinator = settingsCoordinator
        _settingsViewModel = StateObject(wrappedValue: settingsCoordinator.createSettingsViewModel())
    }
    
    var body: some View {
        SettingsView(settingsViewModel: settingsViewModel)
    }
}
