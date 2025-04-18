//
//  NavigationDemoMethod2Screen.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2025/4/17.
//

import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self.toggle()
    }
}


/// 跳頁 Demo Screen (方法二)
struct NavigationDemoMethod2Screen: View {
    @Binding var isActive : Bool
    
    var body: some View {
        VStack {
            Text("Root")
            NavigationLink("Push", destination: NavigationDemoMethod2Screen2(), isActive: self.$isActive)
                .isDetailLink(false)
        }
        .navigationBarTitle("Root")
    }
}

struct NavigationDemoMethod2Screen2: View {
    @State private var isActive: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    var body: some View {
        VStack {
            Text("Two")
            NavigationLink(("Push"), destination: NavigationDemoMethod2Screen3(), isActive: $isActive)
                .isDetailLink(false)
            Button (action: { self.presentationMode.wrappedValue.dismiss() } )
            { Text("Pop") }
            Button (action: { self.rootPresentationMode.wrappedValue.dismiss() } )
            { Text("Pop to root") }
        }
        .navigationBarTitle("Two")
    }
}

struct NavigationDemoMethod2Screen3: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    var body: some View {
        VStack {
            Text("Three")
            
            Button (action: { self.presentationMode.wrappedValue.dismiss() } )
            { Text("Pop") }

            Button (action: { self.rootPresentationMode.wrappedValue.dismiss() } )
            { Text("Pop to root") }
        }
        .navigationBarTitle("Three")
    }
}
