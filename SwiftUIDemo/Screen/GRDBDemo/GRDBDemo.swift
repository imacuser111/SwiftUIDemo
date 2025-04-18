//
//  GRDBDemo.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/8.
//

import GRDB
import GRDBQuery
import SwiftUI
import Combine

/// The main application view
struct GRDBDemo: View {
    
    @Query(AnyPlayerRequest())
    private var playerAssociation: [PlayerAssociation]?
    
    var body: some View {
//        NavigationView {
        
        VStack {
            List(playerAssociation ?? [], id: \.player.id
            
            ) { association in
                Text(association.player.name)
                    .padding(.vertical)
                
                if let name = association.game?.name {
                    Text(name)
                        .padding(.vertical)
                }
            }
            
            emptyFooter()
            
            if playerAssociation != nil {
                populatedFooter()
            }
            
            PlayerList()
        }
        .padding(.horizontal)
        .navigationTitle("@Query Demo")
        .withCustomBackButton {
            AppState.shared.showTabBar()
        }
        //        }
    }
    
    private func emptyFooter() -> some View {
        VStack {
            CreatePlayerButton("Create a Player")
        }
    }
    
    private func populatedFooter() -> some View {
        VStack(spacing: 10) {
            DeletePlayersButton("Delete Player")
        }
    }
}

/// A @Query request that observes the player (any player, actually) in the database
private struct AnyPlayerRequest: ValueObservationQueryable {
    static var defaultValue: [PlayerAssociation]? { nil }
    
    func fetch(_ db: Database) throws -> [PlayerAssociation]? {
        PlayerAssociation.fetchSomePlayers(db, limit: 10)
        
//        try Player.fetchOne(db)
    }
}

// MARK: - Previews

#Preview("Database Initially Empty") {
    GRDBDemo()
}

#Preview("Database Initially Populated") {
    GRDBDemo()
}

class PlayerListModel: ObservableObject {
    @Published var limit: Int = 0 // 驅動 fetchPlayers
    @Published var association: [PlayerAssociation] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        observePlayers()
        
        $limit
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in self?.observePlayers() }  // limit 變更時重新監聽
            .store(in: &cancellables)
    }
    
    /// 監聽資料庫變更，並自動更新 players
    private func observePlayers() {
        let observation = ValueObservation.tracking { db in
            PlayerAssociation.fetchSomePlayers(db, limit: self.limit) ?? []
        }
        
        observation
            .publisher(in: GRDBManager.shared.dbWriter)
            .sink(receiveCompletion: { error in
                print("Observation error: \(error)")
            }, receiveValue: { [weak self] updatedPlayers in
                DispatchQueue.main.async {
                    self?.association = updatedPlayers
                }
            })
            .store(in: &cancellables)
    }
}

struct PlayerList: View {
    @StateObject var model: PlayerListModel = .init()
    
    var body: some View {
        VStack {
//            List(model.association, id: \.player.id) { association in
//                Text(association.player.name)
//            }
            
            ScrollView {
                LazyVStack {
                    ForEach(model.association, id: \.player.id) { association in
                        Text(association.player.name)
                    }
                }
            }
            
            // 使用 Slider 來控制 minScore
            Slider(value: Binding(
                get: { Double(model.limit) },
                set: { model.limit = Int($0) }
            ), in: 0...10000, step: 1)
            .padding()
        }
    }
}
