//
//  TabScreen.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/20.
//

import SwiftUI

struct TabScreen: View {
    
    @State private var currentTab: TabType = .activityList
    
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        UIKitTabView(shouldShowTabBar: appState.shouldShowTabBar, theme: appState.theme, language: appState.language)
        .onAppear {
            setupTabBarStyle()
            setupNavigationStyle()
            setupTableViewStyle()
        }
        .onChange(of: appState.theme, perform: { _ in
            setupTabBarStyle()
            setupNavigationStyle()
            setupTableViewStyle()
        })
    }
}

// MARK: - Setup Style

extension TabScreen {
    
    /// 設定 TabBer 樣式
    func setupTabBarStyle() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(appState.theme.colorTheme.colorsGrayScale0) // 設定背景色
        
        // 選中和未選中項目顏色
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = UIColor(appState.theme.colorTheme.colorsPrimary500) // 設定選中顏色
        UITabBar.appearance().unselectedItemTintColor = UIColor(appState.theme.colorTheme.colorsGrayScale500) // 設定未選中顏色
    }
    
    /// 設定 Navigation 樣式
    func setupNavigationStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 設定不透明的背景
        appearance.backgroundColor = UIColor(appState.theme.colorTheme.colorsGrayScale0) // 設定背景顏色
        
        appearance.setBackIndicatorImage(.iconsPrev, transitionMaskImage: .iconsPrev)
        
        // 移除底部分隔線
        appearance.shadowColor = .clear
        
        // 設定標題屬性
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(appState.theme.colorTheme.colorsGrayScale1000),
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        
        // 設定 appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // 滾動邊緣使用相同外觀
    }
    
    /// 設定 TabView 樣式
    func setupTableViewStyle() {
        // 移除所有 List 的分隔線
        UITableView.appearance().separatorStyle = .none
    }
}

#Preview {
    TabScreen()
        .environmentObject(AppState.shared)
}
