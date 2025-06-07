//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 30.05.25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            SystemImages.magnifyingglass
                .foregroundStyle(searchText.isEmpty ? ColorConstants.secondaryTextColor : ColorConstants.accentColor)
            TextField(StringConstants.searchBarPlaceHolder, text: $searchText)
                .foregroundStyle(ColorConstants.accentColor)
            
        }
        .overlay(alignment: .trailing) {
            SystemImages.xmarkFill
                .foregroundStyle(ColorConstants.accentColor)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    searchText = ""
                    UIApplication.shared.endEditing()
                }
        }
        .autocorrectionDisabled()
        .padding()
        .font(.headline)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorConstants.backgroundColor)
                .shadow(color: ColorConstants.accentColor.opacity(0.15), radius: 10, x: 0, y: 0)
        }
        .padding()
    }
}

#Preview {
    Group {
        SearchBarView(searchText: .constant(""))
            .colorScheme(.light)
        SearchBarView(searchText: .constant(""))
            .colorScheme(.dark)
    }
}

