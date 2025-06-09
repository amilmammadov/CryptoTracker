//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 06.06.25.
//

import SwiftUI

struct LaunchView<LaunchViewModel: LaunchViewModelProtocol>: View {
    
    @ObservedObject var launchViewModel: LaunchViewModel
    @State private var showLaunchText: Bool = false
    @Binding var showLuanchScreen: Bool
    
    var body: some View {
        ZStack {
            ColorConstants.launchScreenBackgroundColor
                .ignoresSafeArea()
            Images.launchImage
                .resizable()
                .frame(width: 100, height: 100)
                .padding(100)
            ZStack {
                if showLaunchText {
                    HStack(spacing: 0) {
                        ForEach(launchViewModel.launchText.indices, id: \.self){ index in
                            Text(launchViewModel.launchText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(ColorConstants.launchScreenAccentColor)
                                .offset(y: launchViewModel.counter == index ? -5 : 0)
                        }
                    }
                    .transition(.scale.animation(.easeIn))
                }
            }
            .offset(y: 72)
        }
        .onAppear {
            showLaunchText.toggle()
        }
        .onReceive(launchViewModel.timer) { _ in
            withAnimation {
                launchViewModel.handleCounterChange()
                launchViewModel.onFinish = {
                    showLuanchScreen = false
                }
            }
        }
    }
}

#Preview {
    LaunchView(launchViewModel: LaunchViewModel(), showLuanchScreen: .constant(true))
}
