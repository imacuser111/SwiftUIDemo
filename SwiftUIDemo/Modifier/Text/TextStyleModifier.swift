//
//  TextStyleModifier.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/1.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
    
    let style: CTextStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .foregroundStyle { style.color($0.theme.colorTheme) }
    }
}

extension View {
    func textStyle(_ style: CTextStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }
}

#Preview {
    Text("1234")
        .textStyle(.mobileBody2_grayScale1000)
        .environmentObject(AppState.shared)
}
