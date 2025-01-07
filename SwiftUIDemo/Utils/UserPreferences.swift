//
//  UserPreferences.swift
//  BasicStructure
//
//  Created by raxabizze on 2019/3/31.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import Foundation

class UserPreferences {
    
    static let shared = UserPreferences()
    private let userPreferences: UserDefaults
    private init() { userPreferences = UserDefaults.standard }
    
    // keys for UserDefaults
    enum Preferences: String {
        case tabTag
        case language
        case theme
        case partner
        case memberId
        case token
    }
    
    /// TabBar Tag
    var tabTag: Int {
        get { userPreferences.integer(forKey: Preferences.tabTag.rawValue) }
        set { userPreferences.set(newValue, forKey: Preferences.tabTag.rawValue) }
    }
    
    /// 語系
    var language: String {
        get { userPreferences.string(forKey: Preferences.language.rawValue) ?? "" }
        set { userPreferences.set(newValue, forKey: Preferences.language.rawValue) }
    }
}
