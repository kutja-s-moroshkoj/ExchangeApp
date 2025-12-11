//
//  PortfolioDataService.swift
//  ScreenEx
//
//  Created by Ростислав on 11.12.2025.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading CORE DATA \(error)")
            }
        }
    }
    
    private func getPortfolio() {
        
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching PORTFOLIO ENTITY \(error)")
        }
    }
}
