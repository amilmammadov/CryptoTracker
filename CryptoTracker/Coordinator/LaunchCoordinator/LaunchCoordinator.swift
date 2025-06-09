//
//  LaunchCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 09.06.25.
//

import SwiftUI

final class LaunchCoordinator: ObservableObject {
    
    func createLaunchViewModel() -> LaunchViewModel {
        let launchViewModel = LaunchViewModel()
        return launchViewModel
    }
}
