//
//  Games.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/9.
//

import Foundation
import GRDB

// Equatable for testability
/// A Game.
public struct Game: Codable, Hashable, Sendable {
    private(set) public var id: Int64?
    public var name: String
    public var score: Int
    
    public init(
        id: Int64? = nil,
        name: String,
        score: Int)
    {
        self.id = id
        self.name = name
        self.score = score
    }
}

// MARK: - Persistence

/// Make entity a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension Game: FetchableRecord, PersistableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    enum Columns {
        static let name = Column(CodingKeys.name)
        static let score = Column(CodingKeys.score)
    }
    
    internal mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

extension GRDBManager {
    /// Access to the entitys database
    var gameRepository: GameRepository {
        .init(dbWriter: dbWriter)
    }
}
