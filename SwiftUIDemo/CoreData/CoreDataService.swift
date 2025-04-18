//
//  CoreDataService.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/10.
//

import CoreData

protocol CoreDataService {
    associatedtype Entity: NSManagedObject
    
    func create()
    func fetchAll() -> [Entity]
    func delete(entity: Entity)
    func deleteAll()
}
