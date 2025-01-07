//
//  Version.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/11/5.
//

import Foundation

/// App 常數
struct AppContanst {
    static let appStoreURL : String = "https://apps.apple.com/us/app/fot-inspector/id6737944124"
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "未知版本"
    static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "未知編譯號"
}
