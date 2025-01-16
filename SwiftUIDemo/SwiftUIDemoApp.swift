//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2024/12/17.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    
    @StateObject private var appState = AppState.shared
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabScreen()
                
                if appState.willShowProgressView {
                    Color.black.opacity(0.6)
                        .overlay {
                            ProgressView()
                                .tint(.white)
                        }
                }
            }
            .environmentObject(appState)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .grdbManager()
        }
    }
}
