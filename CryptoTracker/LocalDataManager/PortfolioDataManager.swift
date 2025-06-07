//
//  PorfolioDataManager.swift
//  CryptoTracker
//
//  Created by Amil Mammadov on 31.05.25.
//

import Foundation
import CoreData

final class PortfolioDataManager {
    static let shared = PortfolioDataManager()
    private let entityName: String = "PortfolioEntity"
    private let containerName: String = "PortfolioContainer"
    private let persistentContainer: NSPersistentContainer
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    private init(){
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print("DEBUG: Error loading Core Data \(error.localizedDescription)")
            }
        }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        if let portfolioEntity = savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                updateSavedCoinInPortfolio(portfolioEntity: portfolioEntity, amount: amount)
            } else {
                removeSavedCoinFromPortfolio(portfolioEntity: portfolioEntity)
            }
        } else {
            saveCoinToPortfolio(coin: coin, amount: amount)
        }
    }
    
    func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("DEBUG: Error fetching portfolio coins \(error.localizedDescription)")
        }
    }
    
    private func saveCoinToPortfolio(coin: CoinModel, amount: Double){
        let portfolioEntity = PortfolioEntity(context: persistentContainer.viewContext)
        portfolioEntity.amount = amount
        portfolioEntity.coinId = coin.id
        applyChanges()
    }
    
    private func updateSavedCoinInPortfolio(portfolioEntity: PortfolioEntity, amount: Double){
        portfolioEntity.amount = amount
        applyChanges()
    }
    
    private func removeSavedCoinFromPortfolio(portfolioEntity: PortfolioEntity){
        persistentContainer.viewContext.delete(portfolioEntity)
        applyChanges()
    }
    
    private func applyChanges(){
        do{
            try persistentContainer.viewContext.save()
        } catch {
            print("DEBUG: Error saving coin to portfolio \(error.localizedDescription)")
        }
        getPortfolio()
    }
}
