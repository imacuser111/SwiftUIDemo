//
//  Login.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/21.
//

import Foundation

/// 登入
struct LoginAPIRequest: APIRequest {
    
    let method: NetworkConstants.HTTPMethod = .POST
    
    let path: NetworkConstants.ApiPathConstants = .Login
    
    let body: Encodable
    
    let contentType: NetworkConstants.ContentType = .json
    
    /// 初始化
    /// - Parameters:
    ///   - partner: 公司號
    ///   - memberId: 驗票帳號
    ///   - password: 密碼
    init(partner: String, member_id: String, password: String) {
        let request = LoginRequest(partner: partner, member_id: member_id, password: password)
        body = request
    }
}

private struct LoginRequest: Encodable {
    /// 公司號
    let partner: String
    /// 驗票帳號
    let member_id: String
    /// 密碼
    let password: String
}

struct LoginResponse: Decodable {
    /// 公司號
    let partner: String
    /// 驗票帳號
    let member_id: String
    /// 登入 token
    let token: String
}
