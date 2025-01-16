//
//  CoreDataService.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/10.
//

import CoreData

protocol CoreDataService {
    associatedtype Entity: NSManagedObject
    
    func create(entity: Entity)
    func fetchAll() -> [Entity]
    func update(entity: Entity)
    func delete(entity: Entity)
}
