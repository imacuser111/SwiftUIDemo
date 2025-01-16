//
//  ImageTimestampProfile.swift
//  Qpp
//
//  Created by Cheng-Hong on 2022/12/5.
//

import Foundation
import GRDB

/// 玩家關聯表
struct PlayerAssociation: FetchableRecord, Decodable {
    let player: Player
    /// 遊戲
    let game: Game?
}

// MARK: Reference 關連相關

extension Player {
    
    // 3. 創建要求: belongsTo: 子表屬於哪張主表(Entity.self)，這邊示範的是子表，如果你是主表則會用hasMany or hasOne 取決於你這張表底下有幾個子元素
    static let gameForeignKey = ForeignKey([Game.Columns.score.name], to: [Player.Columns.score.name])
    
    static let games = hasMany(Game.self, using: gameForeignKey)
}

extension PlayerAssociation {
    // 取得遊戲資訊
    /// - Returns: 遊戲資訊
    static func fetchOne(_ db: Database) -> Self? {
        let request = Player
            .including(optional: Player.games)
        
        return try? fetchOne(db, request)
    }
}
