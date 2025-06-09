//
//  SettingsCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 08.06.25.
//

import SwiftUI

final class SettingsCoordinator: ObservableObject {
    
    func start() -> some View {
        SettingsCoordinatorView(settingsCoordinator: self)
    }
    
    func createSettingsViewModel() -> SettingsViewModel {
        let settingsViewModel = SettingsViewModel()
        return settingsViewModel
    }
}
