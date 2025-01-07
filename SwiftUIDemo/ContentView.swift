//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2024/12/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .withCustomBackButton {
            AppState.shared.showTabBar()
        }
    }
}

#Preview {
    ContentView()
}
