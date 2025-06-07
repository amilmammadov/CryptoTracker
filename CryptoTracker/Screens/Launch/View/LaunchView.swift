//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 06.06.25.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var launchText: [String] = StringConstants.launchScreenText.map { String($0) }
    @State private var showLaunchText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLuanchScreen: Bool
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
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
                        ForEach(launchText.indices, id: \.self){ index in
                            Text(launchText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(ColorConstants.launchScreenAccentColor)
                                .offset(y: counter == index ? -5 : 0)
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
        .onReceive(timer) { _ in
            withAnimation {
                if counter == launchText.count - 1 {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLuanchScreen = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLuanchScreen: .constant(true))
}
