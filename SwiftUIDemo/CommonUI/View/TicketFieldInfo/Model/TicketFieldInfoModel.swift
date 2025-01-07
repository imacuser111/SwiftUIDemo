//
//  TicketFieldModel.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/11/6.
//

import Foundation
import SwiftUI

extension TicketFieldInfo {
    /// 欄位
    enum Field: String, CaseIterable {
        /// 票種
        case ticketType
        /// 座位
        case seat
        /// 姓名
        case name
        /// 身份證字號
        case identityNumber
        /// 訂單編號
        case orderId
        /// 票號(UC)
        case qppTicketId
        
        var rawValue: String {
            switch self {
            case .ticketType:
                LocalizationList.ID_TicketType
            case .seat:
                LocalizationList.ID_Seat
            case .name:
                LocalizationList.ID_Name
            case .identityNumber:
                LocalizationList.ID_IdentityNumber
            case .orderId:
                LocalizationList.ID_OrderNumber
            case .qppTicketId:
                LocalizationList.ID_TicketNumberUC
            }
        }
    }
    
    /// 詳細
    struct Detail {
        /// 票種
        let zoneName: String
        /// 座位
        let position: String?
        /// 真實姓名。實名制用，當不為空時驗票人員要查看對方證件
        let realName: String?
        /// 身份證。實名制用，當不為空時驗票人員要查看對方證件
        let idCardNumber: String?
        /// 訂單編號
        let orderId: String?
        /// 票號
        let qppTicketId: String?
        
        init(zoneName: String, position: String?, realName: String?, idCardNumber: String?, orderId: String? = nil, qppTicketId: String? = nil) {
            self.zoneName = zoneName
            self.position = position
            self.realName = realName
            self.idCardNumber = idCardNumber
            self.orderId = orderId
            self.qppTicketId = qppTicketId
        }
        
        static let fakeData: Self = .init(zoneName: "zoneName", position: "position", realName: "realName", idCardNumber: "idCardNumber", orderId: "orderId", qppTicketId: "qppTicketId")
    }
}
