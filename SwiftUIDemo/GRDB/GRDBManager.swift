//
//  GRDBManager.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/19.
//

import Foundation
import GRDB

/// GRDBManager lets the application access the database.
///
/// It applies the pratices recommended at
/// https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md
final class GRDBManager {
    
    /// The database for the application
    static let shared = makeShared()
    
    static let fileName = "grdb.db"
    
    /// Provides access to the database.
    ///
    /// Application can use a `DatabasePool`, and tests can use a fast
    /// in-memory `DatabaseQueue`.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
    let dbWriter: DatabaseWriter
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
        //        migrator.eraseDatabaseOnSchemaChange = true
        
        // 2. Define the database schema
        migrator.registerMigration("v1") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.createTable()
        }

        return migrator
    }
    
    /// Creates an `GRDBManager`, and make sure the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
        
    }
    
    private static func makeShared() -> GRDBManager {
        do {
            // Create a folder for storing the SQLite database, as well as
            // the various temporary files created during normal database
            // operations (https://sqlite.org/tempfiles.html)
            let fileManager = FileManager.default
            
            // 1. Open a database connection
            let fileURL = try getDatabaseURL(fileManager, fileName: fileName)
            
            let dbQueue = try DatabaseQueue(path: fileURL.path)
            
            // Create the GRDBManager
            let manager = try GRDBManager(dbQueue)
            
            return manager
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate.
            //
            // Typical reasons for an error here include:
            // * The parent directory cannot be created, or disallows writing.
            // * The database is not accessible, due to permissions or data protection when the device is locked.
            // * The device is out of space.
            // * The database could not be migrated to its latest schema version.
            // Check the error message to determine what the actual problem was.
            fatalError("Unresolved error \(error)")
        }
    }
    
    /// 取得資料庫路徑
    static func getDatabaseURL(_ fileManager: FileManager, fileName: String, create: Bool = true) throws -> URL {
        try fileManager
            .url(for: .allLibrariesDirectory, in: .userDomainMask, appropriateFor: nil, create: create)
            .appendingPathComponent(fileName) // 原 SQLite 數據庫文件的 URL
    }
    
    /// 檢查資料庫中是否存在指定的表
    static func isTableExists(tableName: String, inDatabase dbQueue: DatabaseQueue) -> Bool {
        do {
            let result = try dbQueue.read { db in
                return try db.tableExists(tableName)
            }
            return result
        } catch {
            print("Failed to check table existence: \(error)")
            return false
        }
    }
}

