//
//  LoginTextFieldStyle.swift
//  TestSwiftUI
//
//  Created by mike on 2024/10/1.
//

import SwiftUI

/// 輸入邊框樣式
struct TextFieldBorderStyle<S: ShapeStyle>: ViewModifier {
    
    @EnvironmentObject private var appState: AppState
    
    let borderColor: (AppState) -> S
    
    private var cornerRadius: CGFloat
     
    init(_ borderColor: @escaping (AppState) -> S, cornerRadius: CGFloat = 8) {
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .overlay(
                borderColor(appState),
                in: .rect(cornerRadius: cornerRadius).stroke(lineWidth: 1)
            )
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white)
            }
    }
}

// MARK: extension View
extension View {
    
    /// 輸入邊框樣式
    func textFieldBorderStyle(_ borderColor: @escaping (AppState) -> some ShapeStyle) -> some View {
        self.modifier(TextFieldBorderStyle(borderColor))
    }
}
