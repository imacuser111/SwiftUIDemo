//
//  WKImageView.swift
//  GashTickets
//
//  Created by mike on 2024/10/8.
//

import SwiftUI

typealias ImageThemeCallBack = (ImageTheme) -> ImageResource

/// 擁有主題的圖片元件
struct WKImageView: View {
    
    @EnvironmentObject private var appState: AppState
    
    private let modifiers: ((Image) -> Image)?
    private var resource: ImageThemeCallBack
    
    init(
        _ resource: @escaping ImageThemeCallBack,
        modifiers: ((Image) -> Image)? = nil
    ) {
        self.resource = resource
        self.modifiers = modifiers
    }

    var body: Image {
        modifiers?(Image(resource(appState.theme.imageTheme))) ?? Image(resource(appState.theme.imageTheme))
    }
}

#Preview {
    WKImageView({ $0.logo }, modifiers: { $0.resizable() })
        .frame(width: 200, height: 25)
}
