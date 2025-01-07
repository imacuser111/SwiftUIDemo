//
//  BaseRequest.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/21.
//

import Foundation

struct BaseRequest: Encodable {
    /// 公司號
    let partner: String
    /// 驗票帳號
    let member_id: String
    /// 登入 token
    let token: String?
}
