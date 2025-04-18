//
//  NavigationDemoScreen.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/4/17.
//

import SwiftUI

struct NavigationDemoScreen: View {
    @State private var isActive : Bool = false
    @State private var isActive2 : Bool = false
    
    @State private var test: Bool = false
    
    var body: some View {
        WKNavigation {
            VStack(spacing: 32) {
                NavigationLink("method 1", destination: NavigationDemoMethodScreen(), isActive: self.$isActive)
                NavigationLink("method 2", destination: NavigationDemoMethod2Screen(isActive: $test), isActive: self.$isActive2)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentationMode, $test) // ✅ 手動傳遞
    }
}

#Preview {
    NavigationDemoScreen()
}
