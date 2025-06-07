//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 28.05.25.
//

import SwiftUI
import Combine

final class CoinImageViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var image: Image?
    private var cancelables: Set<AnyCancellable> = []
    
    func downloadImage(path: String, imageName: String){
        DownloadImage.shared.getCoinImage(path: path, imageName: imageName)
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .finished:
                    self.isLoading = false
                case .failure:
                    break
                }
            } receiveValue: { [weak self] image in
                guard let self else { return }
                self.image = image
            }.store(in: &cancelables)
    }
}

