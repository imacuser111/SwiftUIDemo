import Foundation
import GRDB

/// PlayerRepository is responsible for high-level operations on the Entitys database.
struct PlayerRepository: GRDBRequest {
    
    typealias Entity = Player
    
    internal let dbWriter: DatabaseWriter
    
    init(dbWriter: DatabaseWriter) {
        self.dbWriter = dbWriter
    }
    
    // MARK: - Implementation
    //
    // ⭐️ Good practice: when we want to update the database, we define methods
    // that accept a Database connection, because they can easily be composed.
    
    /// 刪除單個
    func deleteOne(_ score: Int) {
        do {
            try dbWriter.write { db in
                if let product = try Entity.filter(Entity.Columns.score == score).fetchOne(db) {
                    try product.delete(db)
                }
            }
        } catch {
            print("UnhandledPurchases DeleteOne Error: \(error)")
        }
    }
}

// MARK: - Database Access: Writes
// The write methods execute invariant-preserving database transactions.
// In this demo repository, they are pretty simple.

extension PlayerRepository {
    /// Inserts a player and returns the inserted player.
    public func insert(_ entity: Entity) throws -> Entity {
        try dbWriter.write { db in
            try entity.inserted(db)
        }
    }
    
    /// Updates the player.
    public func update(_ entity: Entity) throws {
        try dbWriter.write { db in
            try entity.update(db)
        }
    }
    
    /// Deletes all players.
    public func deleteAllPlayer() throws {
        try dbWriter.write { db in
            _ = try Entity.deleteAll(db)
        }
    }
}
