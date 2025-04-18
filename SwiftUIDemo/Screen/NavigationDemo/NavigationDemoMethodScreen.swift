//
//  NavigationDemoMethodScreen.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/4/17.
//

import SwiftUI

class NavigationState: ObservableObject {
    @Published var stack: [Int] = []
    
    func push(_ page: Int) {
        stack.append(page)
    }
    
    func popTo(_ page: Int) {
        while stack.last != page && !stack.isEmpty {
            stack.removeLast()
        }
    }
}


/// 跳頁 Demo Screen (方法一)
struct NavigationDemoMethodScreen: View {
    @StateObject private var navigationState = NavigationState()
    
    var body: some View {
        VStack {
            Text("Root Page")
            NavigationLink(
                destination: FirstView(navigationState: navigationState),
                isActive: Binding(
                    get: { navigationState.stack.contains(1) },
                    set: { if $0 { navigationState.push(1) } else { navigationState.popTo(0) } }
                )
            ) {
                Text("Go to First Page")
            }
            .isDetailLink(false)
        }
    }
}

#Preview {
    NavigationDemoMethodScreen()
}

struct FirstView: View {
    @ObservedObject var navigationState: NavigationState
    
    var body: some View {
        VStack {
            Text("First Page")
            NavigationLink(
                destination: SecondView(navigationState: navigationState),
                isActive: Binding(
                    get: { navigationState.stack.contains(2) },
                    set: { if $0 { navigationState.push(2) } else { navigationState.popTo(1) } }
                )
            ) {
                Text("Go to Second Page")
            }
            .isDetailLink(false)
        }
    }
}

struct SecondView: View {
    @ObservedObject var navigationState: NavigationState
    
    var body: some View {
        VStack {
            Text("Second Page")
            Button("Go Back to Root Page") {
                navigationState.popTo(0)
            }
        }
    }
}

