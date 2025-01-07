//
//  ScreenSize.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/7.
//

import SwiftUI
import Combine


extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

var kSafeAreaInsets: EdgeInsets {
    UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? .init()
}


/// 螢幕尺寸資訊
struct ScreenSizeInfo {
    
    private let size: CGSize
    
    /// safeArea 間距
    let safeAreaInsets: EdgeInsets
    /// 總高度 (包含上下 safeArea)
    let screenHeight: CGFloat
    
    
    init(size: CGSize, safeAreaInsets: EdgeInsets) {
        self.size = size
        self.safeAreaInsets = safeAreaInsets
        self.screenHeight = size.height + safeAreaInsets.top + safeAreaInsets.bottom
    }
    
    
    /// 寬度
    var width: CGFloat {
        size.width
    }
    
    var height: CGFloat {
        size.height
    }
}


private struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue: ScreenSizeInfo =  .init(size: .init(width: 390, height: 844), safeAreaInsets: .init())
}

extension EnvironmentValues {
    /// 忽略 safeArea 的螢幕 Size
    var screenSize: ScreenSizeInfo {
        get { self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
}
