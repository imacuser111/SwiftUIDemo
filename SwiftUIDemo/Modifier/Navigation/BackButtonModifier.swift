//
//  BackButtonModifier.swift
//  NavigationStackApp
//
//  Created by Bartłomiej on 03/04/2023.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    
    @Environment(\.dismiss) private var dismiss
    
    let action: (() -> ())?
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        action?()
                        dismiss()
                    } label: {
                        WKImageView {
                            $0.iconsPrev
                        } modifiers: {
                            $0.resizable()
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 32)
                    }
                }
            }
    }
}

extension View {
    func withCustomBackButton(action: (() -> ())? = nil) -> some View {
        modifier(BackButtonModifier(action: action))
    }
}
