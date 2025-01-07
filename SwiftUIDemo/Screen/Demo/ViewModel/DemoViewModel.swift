//
//  DemoViewModel.swift
//  SwiftUIDemo
//
//  Created by Cheng-Hong on 2024/12/17.
//

import Foundation

class DemoViewModel: ObservableObject {
    @Published var loginResponse: LoginResponse? = nil
    
    @Published var error: Error? = nil
    
    @Published var isShowAlert: Bool = false
    @Published var isShowToast: Bool = false
    
    func login() {
        let request = LoginAPIRequest(partner: "COOLI", member_id: "TEST001", password: "abcd1234")
        
        Task { [weak self] in
            do {
                let response: LoginResponse = try await NetworkManager.shared.requestData(apiRequest: request)
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    self.error = nil
                    self.loginResponse = response
                    AppState.shared.loginSuccess(response: response)
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.error = error
                }
            }
        }
    }
}
