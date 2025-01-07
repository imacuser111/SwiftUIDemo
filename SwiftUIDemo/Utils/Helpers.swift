//
//  Helpers.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/7.
//

import Foundation
import UIKit

//extension Numeric {
//    var realWidth: CGFloat {
//        let screenWidthRatio = UIScreen.main.bounds.width / 390
//        
//        // 將自身轉換成 CGFloat 並乘上螢幕寬度比例
//        return CGFloat(truncating: self as? NSNumber ?? 0) * screenWidthRatio
//    }
//    
//    var realHeight: CGFloat {
//        let screenHeightRatio = UIScreen.main.bounds.height / 844
//        
//        // 將自身轉換成 CGFloat 並乘上螢幕寬度比例
//        return CGFloat(truncating: self as? NSNumber ?? 0) * screenHeightRatio
//    }
//}

/// 取得最頂的 viewController
func topViewController(_ baseVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
    if let nav = baseVC as? UINavigationController {
        return topViewController(nav.visibleViewController)
    }
    if let tab = baseVC as? UITabBarController {
        if let selected = tab.selectedViewController {
            return topViewController(selected)
        }
    }
    if let presented = baseVC?.presentedViewController {
        return topViewController(presented)
    }
    return baseVC
}
