//
//  ConditionalStackLayout.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/24.
//

import SwiftUI

/// 根據條件來選擇堆疊方向的布局
struct ConditionalStackLayout<Content: View>: View {
    let useVStack: Bool
    let spacing: CGFloat
    let content: () -> Content
    
    init(useVStack: Bool, spacing: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.useVStack = useVStack
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        if useVStack {
            VStack(spacing: spacing, content: content)
        } else {
            HStack(spacing: spacing, content: content)
        }
    }
}
