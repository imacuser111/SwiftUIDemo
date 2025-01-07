//
//  View+RoundCornerWithBorder.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/9.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RoundedCornerWithBorderModifier: ViewModifier {
    @EnvironmentObject private var appState: AppState
    
    let resource: ColorThemeCallBack
    
    let lineWidth: CGFloat
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(lineWidth: CGFloat, radius: CGFloat, corners: UIRectCorner, resource: @escaping ColorThemeCallBack) {
        self.lineWidth = lineWidth
        self.radius = radius
        self.corners = corners
        self.resource = resource
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedCorner(radius: radius, corners: corners))
            .overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(resource(appState.theme.colorTheme), lineWidth: lineWidth))
    }
}

extension View {
    /// 帶有邊框的圓角
    func roundedCornerWithBorder(lineWidth: CGFloat = 1, radius: CGFloat, corners: UIRectCorner = .allCorners, resource: @escaping ColorThemeCallBack) -> some View {
        modifier(RoundedCornerWithBorderModifier(lineWidth: lineWidth, radius: radius, corners: corners, resource: resource))
    }
}
