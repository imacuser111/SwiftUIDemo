//
//  UIKitTabView.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/11/19.
//

import SwiftUI
import Combine
import UIKit

// Step 1: 创建一个 UITabBarController 的封装
class TabViewController: UITabBarController {
    
    let tabTypes: [TabScreen.TabType] = TabScreen.TabType.allCases
    
    deinit {
        print("deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(CustomTabBar(), forKey: "tabBar")
        
        viewControllers = tabTypes.map { UIHostingController(rootView: $0) }
    }
    
    /// 設置客製化邊線
    func setupCustomTabBarBorder(theme: ThemeType) {
        // 移除默认的分割线
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        // 添加自定义分割线
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 2)
        borderLayer.backgroundColor = UIColor(theme.associatedObject.color.colorsGrayScale100).cgColor
        tabBar.layer.addSublayer(borderLayer)
        
        // 設定 Tabbar Item
        tabBar.items?.enumerated()
            .forEach {
                let tab = tabTypes[$0.offset]
                
                $0.element.tag = tab.rawValue
                $0.element.title = tab.title
                $0.element.image = tab.getUnSelectImage(imageTheme: theme.imageTheme)
                $0.element.selectedImage = tab.getSelectedImage(imageTheme: theme.imageTheme)
            }
    }
    
    /// 設置 TabBar 隱藏
    func setTabBarHidden(_ shouldShowTabBar: Bool, animated: Bool = true) {
        let duration: TimeInterval = animated ? 0.3 : 0
        UIView.animate(withDuration: duration) { [weak self] in
            self?.tabBar.isHidden = !shouldShowTabBar
        }
    }
}

// 客製化 TabBar
class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 107 // 改變高度
        return sizeThatFits
    }
}

// Step 2: 用 UIViewControllerRepresentable 封装
struct UIKitTabView: UIViewControllerRepresentable {
    
    let shouldShowTabBar: Bool
    let theme: ThemeType
    let language: LanguageType // 為了刷新語系使用(實際上這個參數無人呼叫)
    
    func makeUIViewController(context: Context) -> TabViewController {
        .init()
    }
    
    func updateUIViewController(_ uiViewController: TabViewController, context: Context) {
        uiViewController.setTabBarHidden(shouldShowTabBar, animated: true)
        uiViewController.setupCustomTabBarBorder(theme: theme)
    }
}
