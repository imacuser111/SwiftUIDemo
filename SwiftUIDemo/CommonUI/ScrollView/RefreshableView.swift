//
//  RefreshableView.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/16.
//

import SwiftUI

/// 下拉刷新
struct RefreshableView<Content: View>: View {
    
    var content: () -> Content
    
    @Environment(\.refresh) private var refresh   // << refreshable injected !!
    @State private var isRefreshing = false

    var body: some View {
        if #available(iOS 16, *) {
            content()
        } else {
            VStack {
                if isRefreshing {
                    ProgressView()
                        .padding()
                }
                content()
            }
            .animation(.default, value: isRefreshing)
            .background(GeometryReader {
                // detect Pull-to-refresh
                Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) {
                if $0 < -250 && !isRefreshing {   // << any creteria we want !!
                    isRefreshing = true
                    Task {
                        await refresh?()           // << call refreshable !!
                        await MainActor.run {
                            isRefreshing = false
                        }
                    }
                }
            }
        }
    }
}

public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
