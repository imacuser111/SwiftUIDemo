//
//  WKDivider.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/30.
//

import SwiftUI

/// 帶有主題的分割線元件
struct WKDivider: View {
    
    let resource: ColorThemeCallBack
    let height: CGFloat
    
    init(height: CGFloat = 1, resource: @escaping ColorThemeCallBack = { $0.colorsGrayScale100 }) {
        self.height = height
        self.resource = resource
    }
    
    var body: some View {
        WKColor(resource: resource).frame(height: height)
    }
}

#Preview {
    WKDivider()
}
