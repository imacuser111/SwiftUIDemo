//
//  CTextStyle.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/1.
//

import SwiftUI

enum CTextStyle {
    
    /// 32pt
    case mobileH1_grayScale1000
    /// 24pt
    case mobileH3_grayScale1000
    case mobileH3_grayScale0
    /// 20pt
    case mobileH4_grayScale0
    case mobileH4_grayScale700
    /// 18pt
    case mobileH5_grayScale150
    /// 18pt
    case mobileBody1_grayScale1000
    case mobileBody1_grayScale700
    case mobileBody1_grayScale400
    /// 16pt
    case mobileBody2_grayScale1000
    case mobileBody2_grayScale900
    case mobileBody2_grayScale850
    case mobileBody2_grayScale700
    case mobileBody2_grayScale500
    case mobileBody2_grayScale300
    case mobileBody2_grayScale150
    case mobileBody2_grayScale0
    case mobileH6_grayScale1000
    case mobileH6_error500
    /// 14pt
    case mobileBody3_error500
    case mobileBody3_grayScale900
    case mobileBody3_grayScale500
    case mobileBody3_grayScale100
    case mobileBody3_grayScale0
    case mobileBody3_primary500
    /// 12pt
    case mobileCpation_grayScale500
    case mobileCpation_grayScale400
    case mobileCpation_grayScale150
    case mobileCpation_grayScale0
    case desktopCaption_success500
    case desktopCaption_error500
    
    var uiFont: UIFont {
        switch self {
        case .mobileH1_grayScale1000:
            return .mobileH1
        case .mobileH3_grayScale1000, .mobileH3_grayScale0:
            return .mobileH3
        case .mobileH4_grayScale0, .mobileH4_grayScale700:
            return .mobileH4
        case .mobileH5_grayScale150:
            return .mobileH5
        case .mobileH6_grayScale1000, .mobileH6_error500:
            return .mobileH6
        case .mobileBody1_grayScale400, .mobileBody1_grayScale700, .mobileBody1_grayScale1000:
            return .mobileBody1
        case .mobileBody2_grayScale1000,
                .mobileBody2_grayScale700,
                .mobileBody2_grayScale500,
                .mobileBody2_grayScale0,
                .mobileBody2_grayScale850,
                .mobileBody2_grayScale900,
                .mobileBody2_grayScale300,
                .mobileBody2_grayScale150:
            return .mobileBody2
        case .mobileBody3_grayScale100,
                .mobileBody3_error500,
                .mobileBody3_grayScale500,
                .mobileBody3_grayScale0,
                .mobileBody3_primary500,
                .mobileBody3_grayScale900:
            return .mobileBody3
        case .mobileCpation_grayScale400,
                .mobileCpation_grayScale500,
                .desktopCaption_success500,
                .desktopCaption_error500,
                .mobileCpation_grayScale150,
                .mobileCpation_grayScale0:
            return .mobileCpation
        }
    }
    
    var font: Font {
       Font(uiFont)
    }
    
    func color(_ theme: ColorTheme) -> Color {
        switch self {
        case .mobileH4_grayScale0, 
                .mobileH3_grayScale0,
                .mobileBody3_grayScale0,
                .mobileBody2_grayScale0,
                .mobileCpation_grayScale0:
            theme.colorsGrayScale0
        case .mobileBody3_grayScale100:
            theme.colorsGrayScale100
        case .mobileCpation_grayScale150, .mobileH5_grayScale150, .mobileBody2_grayScale150:
            theme.colorsGrayScale150
        case .mobileCpation_grayScale400, .mobileBody1_grayScale400:
            theme.colorsGrayScale400
        case .mobileBody2_grayScale500, .mobileCpation_grayScale500, .mobileBody3_grayScale500:
            theme.colorsGrayScale500
        case .mobileBody2_grayScale700, .mobileBody1_grayScale700, .mobileH4_grayScale700:
            theme.colorsGrayScale700
        case .mobileBody2_grayScale1000, 
                .mobileH1_grayScale1000,
                .mobileBody1_grayScale1000,
                .mobileH6_grayScale1000,
                .mobileH3_grayScale1000:
            theme.colorsGrayScale1000
        case .desktopCaption_success500:
            theme.colorsSuccess500
        case .mobileBody3_error500, .desktopCaption_error500, .mobileH6_error500:
            theme.colorsError500
        case .mobileBody2_grayScale850:
            theme.colorsGrayScale850
        case .mobileBody2_grayScale900, .mobileBody3_grayScale900:
            theme.colorsGrayScale900
        case .mobileBody2_grayScale300:
            theme.colorsGrayScale300
        case .mobileBody3_primary500:
            theme.colorsPrimary500
        }
    }
}
