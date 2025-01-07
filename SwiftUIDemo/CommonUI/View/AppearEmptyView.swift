//
//  AppearEmptyView.swift
//  GashTickets
//
//  Created by mike on 2024/11/8.
//

import SwiftUI

/// 專門觸發 onAppear 的不顯示 View
/// 用 Rectangle 主要是 Spacer、EmptyView 不會觸發 onAppear 事件。
struct AppearEmptyView: View {
    
    let action: () -> Void
    
    var body: some View {
        Rectangle()
           .frame(width: 0, height: 0)
           .hidden()
           .onAppear {
               action()
           }
    }
}

#Preview {
    AppearEmptyView(action: {})
}
