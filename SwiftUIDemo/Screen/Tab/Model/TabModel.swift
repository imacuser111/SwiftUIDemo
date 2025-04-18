//
//  TabModel.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/20.
//

import SwiftUI

extension TabScreen {
    enum TabType: Int, View, CaseIterable {
        /// 資訊
        case info
        /// 活動清單
        case activityList
        /// 跳頁 Demo
        case navigationDemo
        
        var body: some View {
            content
        }
        
        @ViewBuilder
        private var content: some View {
            switch self {
            case .info:
                DemoScreen()
            case .activityList:
                ActivityListScreen()
            case .navigationDemo:
                NavigationDemoScreen()
            }
        }
        
        var title: String {
            switch self {
            case .info:
                LocalizationList.ID_AccountData
            case .activityList:
                LocalizationList.ID_ActivityList
            case .navigationDemo:
                "navigationDemo"
            }
        }
        
        func getUnSelectImage(imageTheme: ImageTheme) -> UIImage {
            switch self {
            case .info:
                    .init(resource: imageTheme.iconsUserDefault)
            case .activityList:
                    .init(resource: imageTheme.iconsTicketDefault)
            case .navigationDemo:
                    .init(resource: imageTheme.iconsTicketDefault)
            }
        }
        
        func getSelectedImage(imageTheme: ImageTheme) -> UIImage {
            switch self {
            case .info:
                    .init(resource: imageTheme.iconsUserActive)
            case .activityList:
                    .init(resource: imageTheme.iconsTicketActive)
            case .navigationDemo:
                    .init(resource: imageTheme.iconsTicketDefault)
            }
        }
    }
}
