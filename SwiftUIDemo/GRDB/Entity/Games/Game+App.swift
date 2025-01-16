//
//  Game+App.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/1/9.
//

import Foundation

// Convenience `Player` methods for the app.
extension Game {
    private static let names = [
        "Arthur", "Anita", "Barbara", "Bernard", "Craig", "Chiara", "David",
        "Dean", "Éric", "Elena", "Fatima", "Frederik", "Gilbert", "Georgette",
        "Henriette", "Hassan", "Ignacio", "Irene", "Julie", "Jack", "Karl",
        "Kristel", "Louis", "Liz", "Masashi", "Mary", "Noam", "Nicole",
        "Ophelie", "Oleg", "Pascal", "Patricia", "Quentin", "Quinn", "Raoul",
        "Rachel", "Stephan", "Susie", "Tristan", "Tatiana", "Ursule", "Urbain",
        "Victor", "Violette", "Wilfried", "Wilhelmina", "Yvon", "Yann",
        "Zazie", "Zoé"]
    
    /// Creates a new player with random name and random score
    static func makeRandom(id: Int64? = nil) -> Game {
        .init(
            id: id,
            name: names.randomElement()!,
            score: 10 * Int.random(in: 0...100))
    }
    
    /// A placeholder Player
    static let placeholder = Game(name: "xxxxxx", score: 100)
}

