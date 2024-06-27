//
//  CoreDataServiceProtocol.swift
//  Currency
//
//

import CoreData

protocol CoreDataServiceProtocol: AnyObject {
    func fetchCurrency() throws -> [CurrencyManagedObject]
    func fetchAlert() throws -> [AlertManagedObject]
    func save(completion: @escaping(NSManagedObjectContext) throws -> Void)
    func updateIsFavourite(title: String)
    func updateAlert(value: Double, for id: UUID)
    func deleteAlert(id: UUID)
}
