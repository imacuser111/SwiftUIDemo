//
//  ResourceLoading.swift
//  NewTalk
//
//  Created by hsu tzu Hsuan on 2020/11/17.
//

import Foundation

enum Localization {
    static func string(_ key: String, localization: String? = nil) -> String {
        
        let res = AppState.shared.language.rawValue
        
        return key.localized(res)
        
//        if key != "" {
//            if let localization {
//                return key.localized(localization)
//            }
//            if UserDefaultsAdapter.languageList == LanguageList.systemSetting {
//                return key.localized(LanguageList.systemSetting.localization)
//            }
//            return key.localized(UserDefaultsAdapter.languageList.localization)
//        }
//        return ""
    }
    
//    static func country(_ key: String) -> String {
//        if key != "" {
//            if UserDefaultsAdapter.languageList == LanguageList.systemSetting {
//                return key.localizedCountry(LanguageList.systemSetting.localization)
//            }
//            return key.localizedCountry(UserDefaultsAdapter.languageList.localization)
//        }
//        return ""
//    }
}

extension String {
    func localized() -> String {
        return Localization.string(self)
    }
    
//    func localizedCountry() -> String {
//        return Localization.country(self)
//    }
    
    func localized(_ lang: String) -> String {
        let path = Bundle.main.path(forResource: "Resource.bundle/" + lang, ofType: "lproj")
        
        guard let sourcePath = path, let bundle = Bundle(path: sourcePath) else { return "" }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }

//    func localizedCountry(_ lang: String) -> String {
//        let path = Bundle.main.path(forResource: "Resource.bundle/" + lang, ofType: "lproj")
//        
//        guard let sourcePath = path, let bundle = Bundle(path: sourcePath) else { return "" }
//        
//        return NSLocalizedString(self, tableName: "CountryCode", bundle: bundle, value: "", comment: "")
//    }
}
