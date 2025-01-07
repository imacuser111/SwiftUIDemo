//
//  WKButtonStyle.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/1.
//

import SwiftUI

enum ButtonState {
    case normal, pressed, disabled
}

struct WKButtonStyle: ButtonStyle {
    
    @EnvironmentObject private var appState: AppState
    @Environment(\.isEnabled) var isEnabled
    
    let buttonStyle: CButtonStyle
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        let buttonState = getState(configuration: configuration)

        return configuration.label
            .updateFrame(buttonStyle)
            .border(borderColor(buttonState: buttonState))
            .roundedReactBackground(buttonStyle: buttonStyle, fill: { _ in backgroundColor(buttonState: buttonState) })
            .textStyle(textStyle(buttonState: buttonState))
    }
    
    // 取得按鈕狀態
    private func getState(configuration: Self.Configuration) -> ButtonState {
        !isEnabled ? .disabled : configuration.isPressed ? .pressed : .normal
    }
    
    // 根據狀態設置背景顏色
    private func backgroundColor(buttonState: ButtonState) -> AnyShapeStyle {
        switch buttonState {
        case .normal:
            return buttonStyle.colorType.normal(theme: appState.theme.colorTheme).backgroundColor.shapeStyle
        case .pressed:
            return buttonStyle.colorType.pressed(theme: appState.theme.colorTheme).backgroundColor.shapeStyle
        case .disabled:
            return buttonStyle.colorType.disabled(theme: appState.theme.colorTheme).backgroundColor.shapeStyle
        }
    }
    
    // 根據狀態設置邊框顏色
    private func borderColor(buttonState: ButtonState) -> AnyShapeStyle {
        switch buttonState {
        case .normal:
            return buttonStyle.colorType.normal(theme: appState.theme.colorTheme).borderColor.shapeStyle
        case .pressed:
            return buttonStyle.colorType.pressed(theme: appState.theme.colorTheme).borderColor.shapeStyle
        case .disabled:
            return buttonStyle.colorType.disabled(theme: appState.theme.colorTheme).borderColor.shapeStyle
        }
    }
    
    // 根據狀態設置邊框顏色
    private func textStyle(buttonState: ButtonState) -> CTextStyle {
        switch buttonState {
        case .normal:
            return buttonStyle.colorType.normal(theme: appState.theme.colorTheme).textStyle
        case .pressed:
            return buttonStyle.colorType.pressed(theme: appState.theme.colorTheme).textStyle
        case .disabled:
            return buttonStyle.colorType.disabled(theme: appState.theme.colorTheme).textStyle
        }
    }
}

// MARK: extension View
private extension View {
    
    @ViewBuilder func updateFrame(_ buttonStyle: CButtonStyle) -> some View {
        switch buttonStyle {
        case .none:
            frame(maxWidth: .infinity)
                .contentShape(Rectangle()) // 設置點擊區域為矩形，覆蓋整個框架
        default:
            frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: extension Button
extension Button {
    func styleButton(_ style: CButtonStyle = .oval(type: .primary)) -> some View {
        buttonStyle(WKButtonStyle(buttonStyle: style))
    }
}

#Preview {
    Button {
        print("1234")
    } label: {
        Text("2222")
    }
    .styleButton()
    .environmentObject(AppState.shared)
}
