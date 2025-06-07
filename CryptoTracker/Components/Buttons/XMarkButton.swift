//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 31.05.25.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            SystemImages.xmark
                .font(.headline)
        }

    }
}

#Preview {
    XMarkButton()
}
