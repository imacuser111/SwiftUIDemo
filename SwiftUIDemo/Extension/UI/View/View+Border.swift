//
//  View+Border.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/8.
//

import SwiftUI

struct EdgeBorder: Shape {
    
    let edges: Edge.Set
    let width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var paths = [Path]()
        
        switch edges {
        case .all:
            paths = [top(rect: rect), bottom(rect: rect), leading(rect: rect), trailing(rect: rect)]
        case .vertical:
            paths = [top(rect: rect), bottom(rect: rect)]
        case .horizontal:
            paths = [leading(rect: rect), trailing(rect: rect)]
        case .top:
            paths = [top(rect: rect)]
        case .bottom:
            paths = [bottom(rect: rect)]
        case .leading:
            paths = [leading(rect: rect)]
        case .trailing:
            paths = [trailing(rect: rect)]
        default:
            paths = [top(rect: rect), bottom(rect: rect), leading(rect: rect), trailing(rect: rect)]
        }
        
        return paths.reduce(into: Path()) { $0.addPath($1) }
    }
    
    private func top(rect: CGRect) -> Path {
        Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
    }
    
    private func bottom(rect: CGRect) -> Path {
        Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
    }
    
    private func leading(rect: CGRect) -> Path {
        Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
    }
    
    private func trailing(rect: CGRect) -> Path {
        Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
    }
}

extension View {
    func border(edges: Edge.Set, width: CGFloat = 1, style: @escaping (AppState) -> some ShapeStyle) -> some View {
        overlay(EdgeBorder(edges: edges, width: width).foregroundStyle(style))
    }
}
