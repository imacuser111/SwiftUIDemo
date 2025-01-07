//
//  UIView+Common.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/23.
//

import SwiftUI

extension View {
    /// return some View 時，debug 使用。
    func Print(_ vars: Any...) -> some View {
        for v in vars { print("\(v)") }
        return self
    }

    
    /// 讀取幾何學
    func readGeometry<Key: PreferenceKey, Value>(_ keyPath: KeyPath<GeometryProxy, Value>, key: Key.Type) -> some View where Key.Value == Value {
        overlay {
            GeometryReader {
                Color.clear
                    .preference(key: key, value: $0[keyPath: keyPath])
            }
        }
    }
}
