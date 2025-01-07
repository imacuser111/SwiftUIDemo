//
//  AlertView.swift
//  GashTickets
//
//  Created by mike on 2024/11/20.
//

import SwiftUI

/// 自訂的彈窗 View
struct AlertView: View {
    
    @Binding var isPresentAlert: Bool
    
    let viewModel = AlertViewModel()
    let info: AlertInfo
    let completion: (() -> ())
    
   
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .ignoresSafeArea()
            
            fetchView(info)
                .environmentObject(AppState.shared)
        }
    }
    
    @ViewBuilder
    func fetchView(_ info: AlertInfo) -> some View {
        
        let defaultActions: (AlertAction) -> Void = { [weak viewModel] in
            viewModel?.result = $0 // 不用 State 接，主要是變數不會即時更新。
            isPresentAlert = false
            completion()
        }
        
        switch info.type {
        case .normal:
            GeneralAlert(alertType: info.type, actions: defaultActions)
        }
    }
}

// MARK: ViewModel
class AlertViewModel {
    
    var result: AlertAction?
    
    
    deinit {
        print("deinit \(self) ...")
    }
}
