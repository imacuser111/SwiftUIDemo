//
//  Version.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/12/6.
//

import SwiftUI

/// 版號 Text 元件
struct VersionTextModifier: ViewModifier {
    
    let shouldAddBottom: Bool
    
    var versionText: some View {
        
        var str = "v \(AppContanst.version).\(AppContanst.build)"
        
        #if DEBUG
        str += "-beta"
        #endif
        
        return Text(str)
            .textStyle(.mobileCpation_grayScale500)
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                versionText
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 10 + (shouldAddBottom ? kSafeAreaInsets.bottom : 0))
                    .padding(.trailing, 10)
            }
        }
    }
}

extension View {
    /// 新增版號
    func addVersionText(shouldAddBottom: Bool = false) -> some View {
        self.modifier(VersionTextModifier(shouldAddBottom: shouldAddBottom))
    }
}
