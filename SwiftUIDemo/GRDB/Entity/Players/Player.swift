import GRDB

// Equatable for testability
/// A player.
public struct Player: Codable, Hashable, Sendable {
    private(set) public var id: Int64?
    public var name: String
    public var score: Int
    public var photoID: Int
    
    public init(
        id: Int64? = nil,
        name: String,
        score: Int,
        photoID: Int)
    {
        self.id = id
        self.name = name
        self.score = score
        self.photoID = photoID
    }
}

// MARK: - Persistence

/// Make entity a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension Player: FetchableRecord, PersistableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    enum Columns {
        static let name = Column(CodingKeys.name)
        static let score = Column(CodingKeys.score)
        static let photoID = Column(CodingKeys.photoID)
    }
    
    internal mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

extension GRDBManager {
    /// Access to the entitys database
    var playerRepository: PlayerRepository {
        .init(dbWriter: dbWriter)
    }
}
