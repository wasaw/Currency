//
//  CoreDataServiceProtocol.swift
//  Currency
//
//

import CoreData

protocol CoreDataServiceProtocol: AnyObject {
    func fetchCurrency() throws -> [CurrencyManagedObject]
    func save(completion: @escaping(NSManagedObjectContext) throws -> Void)
    func updateIsFavourite(title: String)
}
