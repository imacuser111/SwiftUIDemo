//
//  View+Color.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/8.
//

import SwiftUI

// MARK: - 前景顏色

struct ForegroundStyleModifier<S: ShapeStyle>: ViewModifier {
    
    @EnvironmentObject var appState: AppState
    
    let style: (AppState) -> S
    
    func body(content: Content) -> some View {
        // foregroundStyle(iOS15出的新的調整器)可以用在任何view裏面，不受形狀限制，概念有點像幫你創建一個形狀，要你對形狀設定style，但他背後其實也是建立在形狀fill上面的，只是在中間再幫你多做一些剪裁調整
        // 但這邊因為RoundedRectangle已經是一個形狀了，所以直接用fill(只能用在形狀上)效能上會比較好
        content
            .foregroundStyle(style(appState))
    }
}

extension View {
    func foregroundStyle(_ style: @escaping (AppState) -> some ShapeStyle) -> some View {
        modifier(ForegroundStyleModifier(style: style))
    }
}

// MARK: - 背景顏色

struct BackgroundModifier<S: ShapeStyle>: ViewModifier {
    
    @EnvironmentObject var appState: AppState
    
    let style: (AppState) -> S
    let ignoresSafeAreaEdges: Edge.Set
    
    func body(content: Content) -> some View {
        // foregroundStyle(iOS15出的新的調整器)可以用在任何view裏面，不受形狀限制，概念有點像幫你創建一個形狀，要你對形狀設定style，但他背後其實也是建立在形狀fill上面的，只是在中間再幫你多做一些剪裁調整
        // 但這邊因為RoundedRectangle已經是一個形狀了，所以直接用fill(只能用在形狀上)效能上會比較好
        content
            .background(style(appState), ignoresSafeAreaEdges: ignoresSafeAreaEdges)
    }
}

extension View {
    func background(_ style: @escaping (AppState) -> some ShapeStyle, ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View {
        modifier(BackgroundModifier(style: style, ignoresSafeAreaEdges: edges))
    }
}

// MARK: - 圓角+背景色

struct RoundedReactBackgroundModifier<S: ShapeStyle>: ViewModifier {
    
    @EnvironmentObject var appState: AppState
    
    let cornerRadius: CGFloat?
    let buttonStyle: CButtonStyle?
    let borderWidth: CGFloat
    let fill: (ThemeType) -> S
    let borderColor: ((ColorTheme) -> S)?
    
    func body(content: Content) -> some View {
        // foregroundStyle(iOS15出的新的調整器)可以用在任何view裏面，不受形狀限制，概念有點像幫你創建一個形狀，要你對形狀設定style，但他背後其實也是建立在形狀fill上面的，只是在中間再幫你多做一些剪裁調整
        // 但這邊因為RoundedRectangle已經是一個形狀了，所以直接用fill(只能用在形狀上)效能上會比較好
        if let buttonStyle {
            switch buttonStyle {
            case .circleHalfRounded, .none:
                content
                    .background(RoundedRectangle(cornerRadius: 0).fill(fill(appState.theme)))
            case .oval:
                content
                    .background(RoundedRectangle(cornerRadius: 8, style: .circular).fill(fill(appState.theme)))
            case .rectangle:
                content
                    .background(Capsule().fill(fill(appState.theme)))
            }
        } else {
            Group {
                if let borderColor, let cornerRadius {
                    content
                        .overlay(
                            borderColor(appState.theme.colorTheme),
                            in: .rect(cornerRadius: cornerRadius).stroke(lineWidth: borderWidth)
                        )
                } else {
                    content
                }
            }
            .background(RoundedRectangle(cornerRadius: cornerRadius ?? 0, style: .circular).fill(fill(appState.theme)))
        }
    }
}

extension View {
    func roundedReactBackground<S: ShapeStyle>(cornerRadius: CGFloat? = nil,
                                               buttonStyle: CButtonStyle? = nil,
                                               borderWidth: CGFloat = 1,
                                               borderColor: ((ColorTheme) -> S)? = nil,
                                               fill: @escaping (ThemeType) -> S) -> some View {
        modifier(RoundedReactBackgroundModifier<S>(cornerRadius: cornerRadius, buttonStyle: buttonStyle, borderWidth: borderWidth, fill: fill, borderColor: borderColor))
    }
}
