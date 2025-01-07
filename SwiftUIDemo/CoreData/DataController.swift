//
//  DataController.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/3.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data Failed to load \(error)")
            }
        }
    }
}
