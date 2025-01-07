//
//  PrimaryNavigationBar.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/8.
//

import SwiftUI

extension View {
    /// 主要的 navigation bar
    func primaryNavigationBar(title: String) -> some View {
        navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .textStyle(.mobileH3_grayScale1000)
                }
            }
    }
}
