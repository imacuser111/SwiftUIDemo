//
//  AppStorage.swift
//  FoodPicker
//
//  Created by Cheng-Hong on 2024/8/29.
//

import SwiftUI

extension AppStorage {
    init(wrappedValue: Value, _ key: UserPreferences.Preferences, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: UserPreferences.Preferences, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: UserPreferences.Preferences, store: UserDefaults? = nil) where Value == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
}
