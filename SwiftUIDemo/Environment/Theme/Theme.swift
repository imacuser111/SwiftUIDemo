//
//  Theme.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/30.
//

import SwiftUI

protocol Theme {
    var image: ImageTheme { get }
    var color: ColorTheme { get }
}

struct LightTheme: Theme {
    let image : ImageTheme = LightImageTheme()
    let color : ColorTheme = LightColorTheme()
}

struct DarkTheme: Theme {
    let image : ImageTheme = DarkImageTheme()
    let color : ColorTheme = DarkColorTheme()
}

enum ThemeType: String {
    case light, dark
    
    var associatedObject: Theme {
        switch self {
        case .light: 
            LightTheme()
        case .dark:
            DarkTheme()
        }
    }
    
    // 只是為了簡短(associatedObject.color/image)方便外部呼叫而已
    var colorTheme: ColorTheme {
        associatedObject.color
    }
    
    var imageTheme: ImageTheme {
        associatedObject.image
    }
}
