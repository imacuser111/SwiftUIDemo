//
//  WKNavigation.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/23.
//

import SwiftUI

struct WKNavigation<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}

/// 跳頁部分寫在 List or VStack 中會導致點某個 Cell 卻每頁都會收到通知而跳頁，因此寫個 Modifier 移到外部實作
struct NavigationDestinationModifier<V: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    
    @ViewBuilder var destination: () -> V
    
    func body(content: Content) -> some View {
        // iOS 16 以上
        if #available(iOS 16.0, *) {
            content
                .navigationDestination(isPresented: $isPresented) {
                    destination()
                }
        } else {
            content
                .background {
                    NavigationLink(
                        destination: destination(),
                        isActive: $isPresented
                    ) {
                        EmptyView()
                    }
                }
        }
    }
}

extension View {
    /// 註冊導航欄目的位置
    func _navigationDestination<V: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> V) -> some View
    {
        modifier(NavigationDestinationModifier(isPresented: isPresented, destination: destination))
    }
}
