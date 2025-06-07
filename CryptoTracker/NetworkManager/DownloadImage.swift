//
//  DownloadImage.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 28.05.25.
//

import SwiftUI
import Combine

final class DownloadImage {
    static let shared = DownloadImage()
    private init(){}
    
    private let folderName: String = "coin_images"
    
    func getCoinImage(path: String, imageName: String) -> AnyPublisher<Image, Never>{
        if let savedImage = LocalFileManager.shared.getImage(imageName: path, folderName: folderName) {
            return Just(Image(uiImage: savedImage)).eraseToAnyPublisher()
        }else {
            return downloadImage(path: path, imageName: imageName)
        }
    }
    
    private func downloadImage(path: String, imageName: String) -> AnyPublisher<Image, Never> {
        guard let url = URL(string: path) else {
            return Just(SystemImages.dollar).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                guard let uiImage = UIImage(data: data) else {
                    throw NetworkError.invalidImageData
                }
                LocalFileManager.shared.saveImage(image: uiImage, imageName: imageName, folderName: self.folderName)
                return Image(uiImage: uiImage)
            }
            .catch({ _ in
                Just(SystemImages.dollar)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
