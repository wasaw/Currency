//
//  CoreDataService.swift
//  Finance
//
//

import CoreData

final class CoreDataService {
    
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
}
