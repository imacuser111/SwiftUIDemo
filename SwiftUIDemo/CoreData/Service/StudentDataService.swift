//
//  StudentDataService.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/10.
//

import Foundation
import CoreData

class StudentDataService: CoreDataService {
    typealias Entity = Student
    
//    static let shared = StudentDataService()
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(entity: Entity) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func fetchAll() -> [Entity] {
        var FavoriteMaps = [Entity]()
        let request: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            FavoriteMaps = try context.fetch(request)
        } catch {
            print("Error fetching FavoriteMaps: \(error)")
        }
        
        return FavoriteMaps
    }
    
    func update(entity: Entity) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func delete(entity: Entity) {
        context.delete(entity)
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
