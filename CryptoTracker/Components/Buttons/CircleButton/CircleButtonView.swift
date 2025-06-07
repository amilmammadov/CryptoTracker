//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 25.05.25.
//

import SwiftUI

struct CircleButtonView: View {
    
    let image: Image
    
    var body: some View {
        image
            .font(.headline)
            .foregroundStyle(ColorConstants.accentColor)
            .frame(width: 52, height: 52)
            .background(
                Circle()
                    .foregroundStyle(ColorConstants.backgroundColor)
            )
            .shadow(color: ColorConstants.accentColor.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
            
    }
}

#Preview {
    Group {
        CircleButtonView(image: SystemImages.plus)
            .colorScheme(.light)
        CircleButtonView(image: SystemImages.plus)
            .colorScheme(.dark)
    }
}
