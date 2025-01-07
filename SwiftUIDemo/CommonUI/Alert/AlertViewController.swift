//
//  AlertViewController.swift
//  GashTickets
//
//  Created by mike on 2024/10/24.
//

import SwiftUI
import UIKit

/// 彈窗要推頁的物件
class AlertViewController: UIHostingController<AlertView> {
    
    /// 緩存彈窗控制器
    static var currentAlertViewController: AlertViewController?
    
    
    let alertView: AlertView
    
    
    init(_ alertView: AlertView) {
        self.alertView = alertView
        super.init(rootView: self.alertView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func showAlert<T>(isPresented: Binding<Bool> = .constant(true), presenting: T? = (), info: @escaping (T) -> AlertInfo) {
        
        if let presenting, isPresented.wrappedValue  {
            
            dismissCurrentAlert {
                presentAlert(isPresented: isPresented, presenting: presenting, info: info) {
                    dismissCurrentAlert()
                }
            }
        }
    }
    
    /// 生成新彈窗
    static private func presentAlert<T>(
        isPresented: Binding<Bool>,
        presenting: T,
        info: @escaping (T) -> AlertInfo,
        completion: @escaping () -> ()
    ) {
        
        let view = AlertView(isPresentAlert: isPresented, info: info(presenting), completion: completion)
        let alertController = AlertViewController(view)
        
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.view.backgroundColor = UIColor.clear
        alertController.modalTransitionStyle = .crossDissolve
        
        let viewController = topViewController()
        viewController?.present(alertController, animated: false, completion: nil)
        
        // 加入緩存
        AlertViewController.currentAlertViewController = alertController
    }
    
    /// 移除現有彈窗
    static private func dismissCurrentAlert(_ completion: (() -> ())? = nil) {
        
        guard let vc = AlertViewController.currentAlertViewController else {
            completion?()
            return
        }
        
        let result = vc.alertView.viewModel.result
        let info = vc.alertView.info
        
        vc.dismiss(animated: false) {
            
            // 清除現在彈窗
            AlertViewController.currentAlertViewController = nil

            // 假如有選擇結果，再設定。
            if let result = result {
                info.actions?(result)
            }
            
            completion?()
        }
    }
}

/// 彈窗資訊
struct AlertInfo {
    
    /// 彈窗類型
    let type: AlertType
    /// 返回事件處理
    let actions: ((AlertAction) -> ())?
    
    
    init(type: AlertType, actions: ((AlertAction) -> ())? = nil) {
        self.type = type
        self.actions = actions
    }
}


// MARK: extension View
extension View {
    
    /// 顯示彈窗
    func showAlert<T>(isPresented: Binding<Bool>, presenting: T? = (), info: @escaping (T) -> AlertInfo) -> some View {
        AlertViewController.showAlert(isPresented: isPresented, presenting: presenting, info: info)
        return self
    }
}
