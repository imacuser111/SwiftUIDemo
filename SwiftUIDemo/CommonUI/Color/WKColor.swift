//
//  WKColor.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/11/21.
//

import SwiftUI

typealias ColorThemeCallBack = (ColorTheme) -> Color

/// 帶有主題的顏色元件
struct WKColor: View {
    
    @EnvironmentObject private var appState: AppState
    
    let resource: ColorThemeCallBack

    var body: some View {
        resource(appState.theme.colorTheme)
    }
}
