//
//  SearchBar.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    let prompt: String
    
    init(searchText: Binding<String>, prompt: String = "") {
        self._searchText = searchText
        self.prompt = prompt
    }
        
    var body: some View {
        HStack {
            IconTextField(
                trailingImages: [.search],
                content: {
                    WKTextField(
                        $searchText,
                        placeholder: prompt
                    )
                }
            )
            .textFieldBorderStyle({ $0.theme.colorTheme.colorsGrayScale150 })
        }
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
        .environmentObject(AppState.shared)
}
