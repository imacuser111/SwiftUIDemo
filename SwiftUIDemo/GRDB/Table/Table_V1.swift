//
//  Database+Table.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/19.
//

import Foundation
import GRDB

/// Extension database for create qpp table
extension Database {
    
    /// 建立資料表
    func createTable() throws {
        try self.createPlayerTable()
        try self.createGameTable()
    }
    
    /// 建立 Player 表
    func createPlayerTable() throws {
        try self.create(table: Player.databaseTableName) { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("name", .text).notNull()
            t.column("score", .integer).notNull()
            t.column("photoID", .integer).notNull()
        }
    }
    
    /// 建立 game 表
    func createGameTable() throws {
        try self.create(table: Game.databaseTableName) { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("name", .text).notNull()
            t.column("score", .integer).notNull()
        }
    }
}
