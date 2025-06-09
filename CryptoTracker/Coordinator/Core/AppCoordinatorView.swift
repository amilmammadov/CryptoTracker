//
//  AppCoordinator.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 08.06.25.
//

import SwiftUI

struct AppCoordinatorView: View {
   
    @StateObject private var homeCoordinator = HomeCoordinator()

    var body: some View {
        homeCoordinator.start()
    }
}
