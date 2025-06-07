//
//  FilaManager.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 28.05.25.
//

import SwiftUI

final class LocalFileManager {
    static let shared = LocalFileManager()
    
    func saveImage(image: UIImage, imageName: String, folderName: String){
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let imageData = image.pngData(),
              let url = getUrlForImage(imagName: imageName, folderName: folderName) else {
            return
        }
        do {
            try imageData.write(to: url)
        } catch {
            print("DEBUG: Image saving error \(error.localizedDescription)")
        }
        
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imagName: imageName, folderName: folderName) else { return nil }
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolderIfNeeded(folderName: String){
        guard let url = getUrlForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("DEBUG: Directory creating error \(error.localizedDescription)")
            }
        }
    }
    
    private func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName, conformingTo: .folder)
    }
    
    private func getUrlForImage(imagName: String, folderName: String) -> URL? {
        guard let url = getUrlForFolder(folderName: folderName) else { return nil }
        return url.appendingPathComponent(imagName, conformingTo: .png)
    }
}
