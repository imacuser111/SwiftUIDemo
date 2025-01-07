//
//  StyleButtonStyleModifier+.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/4.
//

import SwiftUI

/// 自定義Button Style
enum CButtonStyle {
    /// (  Button  )
    /// (label 會有 frame(maxWidth: .infinity, maxHeight: .infinity) 屬性)
    case circleHalfRounded(type: ColorType)
    
    /// cornerRadius = 8
    /// (label 會有 frame(maxWidth: .infinity, maxHeight: .infinity) 屬性)
    case oval(type: ColorType)
    
    /// Button
    /// (label 不會有 frame(maxWidth: .infinity, maxHeight: .infinity) 屬性)
    case none(type: ColorType)
    
    /// rectangle button  
    /// (label 會有 frame(maxWidth: .infinity, maxHeight: .infinity) 屬性)
    case rectangle(type: ColorType)
    
    
    var colorType: ColorType {
        switch self {
        case .circleHalfRounded(let type):
            return type
        case .none(let type):
            return type
        case .oval(let type):
            return type
        case .rectangle(let type):
            return type
        }
    }
}

// MARK: - Button Color
enum CButtonColor {
    
    case color(Color)
    case linearGradient(LinearGradient)
    
    /// 形狀樣式
    var shapeStyle: AnyShapeStyle {
        switch self {
        case .color(let color):
            return AnyShapeStyle(color)
        case .linearGradient(let gradient):
            return AnyShapeStyle(gradient)
        }
    }
}

// MARK: - Button Style
extension CButtonStyle {
    
    struct ButtonColorGroup {
        
        let textStyle: CTextStyle
        let backgroundColor: CButtonColor
        let borderColor: CButtonColor
        
        init(
            textStyle: CTextStyle,
            backgroundColor: CButtonColor = .color(.clear),
            borderColor: CButtonColor = .color(.clear)
        ) {
            self.textStyle = textStyle
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
        }
    }
    
    enum ColorType {
        case primary
        case secondary
        case cancel
        case searchType
        
        func normal(theme: ColorTheme) -> ButtonColorGroup {
            switch self {
            case .primary:
                return .primaryNormal(theme: theme)
            case .secondary:
                return .secondaryNormal(theme: theme)
            case .cancel:
                return .cancelNormal(theme: theme)
            case .searchType:
                return .searchTypeNormal(theme: theme)
            }
        }
        
        func pressed(theme: ColorTheme) -> ButtonColorGroup {
            switch self {
            case .primary:
                return .primaryPressed(theme: theme)
            case .secondary:
                return .secondaryPressed(theme: theme)
            case .cancel:
                return .cancelPressed(theme: theme)
            case .searchType:
                return .searchTypePressed(theme: theme)
            }
        }
        
        func disabled(theme: ColorTheme) -> ButtonColorGroup {
            switch self {
            case .primary:
                return .primaryDisable(theme: theme)
            case .secondary:
                return .secondaryDisable(theme: theme)
            case .cancel:
                return .cancelDisable(theme: theme)
            case .searchType:
                return .searchTypeDisable(theme: theme)
            }
        }
    }
}

// MARK: - primary
// TODO: 背景假如用漸層，之後只能用漸層強制覆蓋，不然無法覆蓋

extension CButtonStyle.ButtonColorGroup {
    static func primaryNormal(theme: ColorTheme) -> Self {
        .init(
            textStyle: .mobileBody2_grayScale0,
            backgroundColor: .linearGradient(.primary(theme: theme))
        )
    }
    
    static func primaryPressed(theme: ColorTheme) -> Self {
        .init(
            textStyle: .mobileBody2_grayScale0,
            backgroundColor: .linearGradient(.init(
                gradient: Gradient(colors: [
                    theme.colorsPrimary500
                ]),
                startPoint: .leading,
                endPoint: .trailing
            ))
        )
    }
    
    static func primaryDisable(theme: ColorTheme) -> Self {
        .init(
            textStyle: .mobileBody2_grayScale0,
            backgroundColor: .linearGradient(.init(
                gradient: Gradient(colors: [
                    theme.colorsGrayScale150
                ]),
                startPoint: .leading,
                endPoint: .trailing
            ))
        )
    }
}

// MARK: - secondary

extension CButtonStyle.ButtonColorGroup {
    static func secondaryNormal(theme: ColorTheme) -> Self {
        .init(
            textStyle: .mobileBody2_grayScale0,
            backgroundColor: .color(theme.colorsGrayScale850)
        )
    }
    
    static func secondaryPressed(theme: ColorTheme) -> Self {
        .init(
            textStyle: .mobileBody2_grayScale0,
            backgroundColor: .color(theme.colorsGrayScale1000)
        )
    }
    
    static func secondaryDisable(theme: ColorTheme) -> Self {
        .init(
            textStyle: .mobileBody2_grayScale0,
            backgroundColor: .color(theme.colorsGrayScale150)
        )
    }
}

// MARK: - cancel

extension CButtonStyle.ButtonColorGroup {
    static func cancelNormal(theme: ColorTheme) -> Self {
        .init(textStyle: .mobileBody2_grayScale900)
    }
    
    static func cancelPressed(theme: ColorTheme) -> Self {
        .init(textStyle: .mobileBody2_grayScale1000)
    }
    
    static func cancelDisable(theme: ColorTheme) -> Self {
        .init(textStyle: .mobileBody2_grayScale300)
    }
}

// MARK: - SearchType

extension CButtonStyle.ButtonColorGroup {
    static func searchTypeNormal(theme: ColorTheme) -> Self {
        .init(textStyle: .mobileBody2_grayScale900, backgroundColor: .color(theme.colorsGrayScale0))
    }
    
    static func searchTypePressed(theme: ColorTheme) -> Self {
        .init(textStyle: .mobileBody2_grayScale900, backgroundColor: .color(theme.colorsGrayScale0))
    }
    
    static func searchTypeDisable(theme: ColorTheme) -> Self {
        .init(textStyle: .mobileBody2_grayScale900, backgroundColor: .color(theme.colorsGrayScale0))
    }
}
