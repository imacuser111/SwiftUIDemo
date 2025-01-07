//
//  AlertType.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/27.
//

import SwiftUI

/// Alert type
enum AlertType {

    /// 圖片樣式
    enum IconStyle {
        case success
        case error
    }
    
    /// 普通
    case normal(
        title: String,
        message: String = "",
        confirmActionText: String,
        cancelActionText: String? = nil,
        iconStyle: IconStyle? = nil
    )
    
    var title: String {
        switch self {
        case .normal(let title, _, _, _, _):
            title
        }
    }
    
    var message: String {
        switch self {
        case .normal(_, let message, _, _, _):
            message
        }
    }
    
    /// Left button action text for the alert view
    var confirmActionText: String {
        switch self {
        case .normal(_, _, let confirmActionText, _, _): 
            confirmActionText
        }
    }
    
    /// Right button action text for the alert view
    var cancelActionText: String? {
        switch self {
        case .normal(_, _, _, let cancelActionText, _):
            cancelActionText
        }
    }
    
    var image: ImageResource? {
        switch self {
        case .normal(_, _, _, _, let iconStyle):
            
            switch iconStyle {
            case .success:
                .iconsCheckCircle
            case .error:
                .iconsCancelCircle
            default:
                nil
            }
        }
    }
}

/// 彈窗動作
enum AlertAction {
    case confirm
    case cancel
}

/// 強制實作返回處理
protocol BaseAlertView: View {
    
    /// 要顯示的資料
    var alertType: AlertType { get }
    /// 按鈕點擊後的動作
    var actions: (AlertAction) -> Void { get }
}
