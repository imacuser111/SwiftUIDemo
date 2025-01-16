//
//  GRDBRequest.swift
//  Qpp
//
//  Created by Cheng-Hong on 2022/11/25.
//

import Foundation
import GRDB
import Combine

/// GRDB 基本要求
protocol GRDBRequest {
    
    associatedtype Entity: FetchableRecord, PersistableRecord
    
    var dbWriter: DatabaseWriter { get }
}

extension GRDBRequest {

    // MARK: - Implementation
    //
    // ⭐️ Good practice: when we want to update the database, we define methods
    // that accept a Database connection, because they can easily be composed.

    func _insert(_ db: Database, entity: Entity) throws {
        try entity.insert(db)
    }

    private func _deleteAll(_ db: Database) throws {
        try Entity.deleteAll(db)
    }

    private func _deleteOne(_ db: Database, entity: Entity) throws {
        try entity.delete(db)
    }

    private func _update(_ db: Database, entity: Entity) throws {
        try entity.update(db)
    }

    private func _fetchAll(_ db: Database) throws -> [Entity] {
        try Entity.fetchAll(db)
    }
}

extension GRDBRequest {
    
    // MARK: - Modify Entitys
    
    // ----------------- Swfit -----------------

    /// 新增entity
    /// - Parameter entity: 實例
    func insert(_ entity: Entity) throws {
        try dbWriter.write { db in try _insert(db, entity: entity) }
    }

    /// 刪除所有entity
    func deleteAll() {
        _ = try? dbWriter.write(_deleteAll)
    }

    /// 刪除單個entity
    /// - Parameter entity: 實例
    func deleteOne(_ entity: Entity) throws {
        _ = try dbWriter.write { db in try _deleteOne(db, entity: entity) }
    }

    /// 更新entity
    /// - Parameter entity: 實例
    func update(_ entity: Entity) throws {
        try dbWriter.write { db in try _update(db, entity: entity) }
    }
    
    // MARK: - Access Entitys
    
    // ----------------- Swfit -----------------

    /// 讀取entity
    /// - Returns: 所有實例
    func fetchAll() throws -> [Entity] {
        try dbWriter.read(_fetchAll)
    }
}


