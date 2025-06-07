//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 27.05.25.
//

import Foundation
import Combine

final class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func fetch<T: Codable>(model: T.Type,
                             request: URLRequest) -> AnyPublisher<T, Error>{
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse, response.statusCode == 204 {
                    throw NetworkError.noContent
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
    }
}
