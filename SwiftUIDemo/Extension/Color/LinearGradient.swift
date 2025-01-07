//
//  LinearGradient.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/15.
//

import SwiftUI

extension LinearGradient {
    
    /// 主色
    static func primary(theme: ColorTheme) -> Self {
        .init(colors: [
            theme.colorsPrimary500,
            theme.colorsLogo500
        ], startPoint: .leading, endPoint: .trailing)
    }
    
    /// 取消
    static func disabled(theme: ColorTheme) -> Self {
        .init(colors: [
            theme.colorsGrayScale200,
            theme.colorsGrayScale200
        ], startPoint: .leading, endPoint: .trailing)
    }
}
