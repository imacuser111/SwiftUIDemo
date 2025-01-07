//
//  AlertViewModifier.swift
//  GashTickets
//
//  Created by mike on 2024/10/24.
//

#warning("mike-記憶體測試時再研究")
//import SwiftUI
//
///// 放在根目錄的彈窗樣式
//struct RootAlertViewModifier: ViewModifier {
//    
//    @EnvironmentObject var alerter: Alerter
//    
//    /// Flag used to dismiss the alert on the presenting view
//    @Binding var isPresentAlert: Bool
//    
//    /// 彈窗類型
//    let info: AlertInfo?
//   
//    
//    init(
//        _ isPresentAlert: Binding<Bool>,
//        info: AlertInfo?
//    ) {
//        self._isPresentAlert = isPresentAlert
//        self.info = info
//    }
//    
//    
//    func body(content: Content) -> some View {
//                
//        ZStack {
//            content
//
//            if isPresentAlert,
//               let info = info {
//
//                ZStack {
//                    
//                    // faded background
//                    Color.black.opacity(0.75)
//                        .edgesIgnoringSafeArea(.all)
//                    
//                    fetchView(info)
//                }
//                .zIndex(2)
//            }
//        }
//    }
//    
//    @ViewBuilder
//    func fetchView(_ info: AlertInfo) -> some View {
//        
//        let defaultActions: (AlertAction) -> Void = {
//            info.actions?($0)
//            isPresentAlert.toggle()
//        }
//        
//        switch info.type {
//        case .checkTicket:
//            CheckTicketAlert(alertType: info.type, actions: defaultActions)
//        case .normal:
//            GeneralAlert(alertType: info.type, actions: defaultActions)
//        }
//    }
//}
//
///// 放在子目錄的彈窗樣式
//struct AlertViewModifier: ViewModifier {
//    
//    @EnvironmentObject var alerter: Alerter
//    
//    @Binding var isPresentAlert: Bool
//
//    let info: AlertInfo?
//    
//
//    init<T>(isPresentAlert: Binding<Bool>, info: @escaping (T) -> AlertInfo, presenting: T?) {
//        self._isPresentAlert = isPresentAlert
//      
//        if let presenting = presenting {
//            self.info = info(presenting)
//        }
//        else {
//            self.info = nil
//        }
//    }
//    
//    func body(content: Content) -> some View {
//        ZStack {
//            
//            content
//            
//            // 有顯示時，才做處理。
//            if isPresentAlert {
//                
//                if let info = info {
//                    
//                    AppearEmptyView { [weak alerter] in
//                        
//                        // 重置外部旗標
//                        alerter?.onAlertClosedTrigger = {
//                            
//                            if isPresentAlert != $0 {
//                                isPresentAlert = $0
//                            }
//                        }
//                        // 顯示介面
//                        alerter?.showAlert(info)
//                    }
//                }
//                else {
//                    AppearEmptyView {
//                        isPresentAlert = false
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//// MARK: extension View
//extension View {
//       
//    /// 顯示彈窗方法
//    func showAlert<T>(
//        isPresentAlert: Binding<Bool>,
//        presenting: T? = (),
//        info: @escaping (T) -> AlertInfo
//    ) -> some View {
//        
//        self.modifier(AlertViewModifier(
//            isPresentAlert: isPresentAlert,
//            info: info,
//            presenting: presenting
//        ))
//    }
//    
//    /// 顯示根的彈窗方法
//    func showRootAlert(
//        _ isPresentAlert: Binding<Bool>,
//        info: AlertInfo?
//    ) -> some View {
//        
//        ModifiedContent(
//            content: self,
//            modifier: RootAlertViewModifier(isPresentAlert, info: info)
//        )
//    }
//}

