//
//  AppState.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/9.
//

import SwiftUI

final class AppState: ObservableObject {
    static let shared: AppState = .init()
    
    @AppStorage(.language) private(set) var language = LanguageType.zhHans
    @AppStorage(.theme) var theme = ThemeType.light
    @AppStorage(.token) private(set) var token = ""
    @AppStorage(.partner) private(set) var partner = ""
    @AppStorage(.memberId) private(set) var memberId = ""
    
    @Published var shouldShowTabBar = true
    
    /// 是否顯示進度視圖
    @Published private(set) var willShowProgressView = false
    
    /// 是否顯示 Toast
    @Published var shouldShowToast = false
    private(set) var toastInfo: String = ""
    private(set) var toastType: ToastType = .error
    
    func switchLanguage(_ type: LanguageType) {
        if type != language {
            language = type
        }
    }
    
    func switchTheme(_ type: ThemeType) {
        if type != theme {
            theme = type
        }
    }
    
    func showTabBar() {
        if !shouldShowTabBar {
            shouldShowTabBar = true
        }
    }
    
    func hiddenTabBar() {
        if shouldShowTabBar {
            shouldShowTabBar = false
        }
    }
    
    func showProgressView() {
        if !willShowProgressView {
            willShowProgressView = true
        }
    }
    
    func hiddenProgressView() {
        if willShowProgressView {
            willShowProgressView = false
        }
    }
    
    private func showToast(_ toast: String, type: ToastType = .error) {
        toastInfo = toast
        toastType = type
        shouldShowToast = true
    }
    
    /// 登入成功
    func loginSuccess(response: LoginResponse) {
        // show 登入成功 Toast
        showToast(LocalizationList.ID_LoginSuccess, type: .default)
        
        partner = response.partner
        memberId = response.member_id
        token = response.token
    }
    
    /// 登出
    func logout() {
        token = ""
    }
}
