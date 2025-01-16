//
//  AppView.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/8.
//

import GRDB
import GRDBQuery
import SwiftUI

/// The main application view
struct AppView: View {
    
    @Query(AnyPlayerRequest())
    private var playerAssociation: PlayerAssociation?
    
    var body: some View {
//        NavigationView {
            VStack {
                Text(playerAssociation?.player.name ?? "")
                    .padding(.vertical)
                
                Text(playerAssociation?.game?.name ?? "")
                    .padding(.vertical)
                
                Spacer()
                
                if playerAssociation != nil {
                    populatedFooter()
                } else {
                    emptyFooter()
                }
            }
            .padding(.horizontal)
            .navigationTitle("@Query Demo")
//        }
    }
    
    private func emptyFooter() -> some View {
        VStack {
            Text("The demo application observes the database and displays information about the player.")
            
            CreatePlayerButton("Create a Player")
        }
    }
    
    private func populatedFooter() -> some View {
        VStack(spacing: 10) {
            Text("What if another application component deletes the player at the most unexpected moment?")
            
            DeletePlayersButton("Delete Player")
            
            Spacer().frame(height: 10)
            Text("What if the player is deleted soon after the Edit button is hit?")
            
            DeletePlayersButton("Delete After", after: {
                print("Delete After")
            })
            
            Spacer().frame(height: 10)
            Text("What if the player is deleted right before the Edit button is hit?")
            
            DeletePlayersButton("Delete Before", before: {
                print("Delete Before")
            })
        }
    }
}

/// A @Query request that observes the player (any player, actually) in the database
private struct AnyPlayerRequest: ValueObservationQueryable {
    static var defaultValue: PlayerAssociation? { nil }
    
    func fetch(_ db: Database) throws -> PlayerAssociation? {
        PlayerAssociation.fetchOne(db)
        
//        try Player.fetchOne(db)
    }
}

// MARK: - Previews

#Preview("Database Initially Empty") {
    AppView()
}

#Preview("Database Initially Populated") {
    AppView()
}
