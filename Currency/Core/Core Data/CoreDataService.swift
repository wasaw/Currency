//
//  CoreDataService.swift
//  Finance
//
//

import CoreData

final class CoreDataService: CoreDataServiceProtocol {
    static let shared = CoreDataService()
    
// MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { _, error in
            guard let error = error else { return }
            print(error)
        }
        return persistentContainer
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

// MARK: - Public API

extension CoreDataService {
    func fetchCurrency() throws -> [CurrencyManagedObject] {
        let fetchRequest = CurrencyManagedObject.fetchRequest()
        
        return try viewContext.fetch(fetchRequest)
    }
    
    func fetchAlert() throws -> [AlertManagedObject] {
        let fetchRequest = AlertManagedObject.fetchRequest()
        return try viewContext.fetch(fetchRequest)
    }

    func save(completion: @escaping(NSManagedObjectContext) throws -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.performAndWait {
            do {
                try completion(backgroundContext)
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateIsFavourite(title: String) {
        let fetchRequest = CurrencyManagedObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title ==%@", title)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            
            if let currency = result.first {
                currency.isFavourite.toggle()
                try viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAlert(value: Double, for id: UUID) {
        let fetchRequest = AlertManagedObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id ==%@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            
            if let alert = result.first {
                alert.alert = value
                try viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAlert(id: UUID) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            let fetchRequest = AlertManagedObject.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id ==%@", id as CVarArg)
            guard let alert = try? backgroundContext.fetch(fetchRequest).first else { return }
            backgroundContext.delete(alert)
            try? backgroundContext.save()
        }
    }
}
