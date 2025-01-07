//
//  TicketFieldInfo.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/11/13.
//

import SwiftUI

/// 票券欄位資訊 (目前用在 CheckTicektAlert、HistoryCell)
struct TicketFieldInfo: View {
    
    let data: TicketFieldInfo.Detail
    
    /// 標題到內容間距
    let titleToContentPadding: CGFloat
    
    /// 標題的 TextStyle
    let titleTextStyle: CTextStyle
    
    /// 內容的 TextStyle
    let contentTextStyle: CTextStyle
    
    var body: some View {
        VStack(spacing: 8) {
            // 票種
            getField(.ticketType, content: data.zoneName)
            
            // 座位
            if let position = data.position, !position.isEmpty {
                getField(.seat, content: position)
            }
            
            // 姓名
            if let name = data.realName, !name.isEmpty {
                getField(.name, content: name)
            }
            
            // 身分證字號
            if let idCardNumber = data.idCardNumber, !idCardNumber.isEmpty {
                getField(.identityNumber, content: idCardNumber)
            }
            
            // 訂單編號
            if let orderId = data.orderId, !orderId.isEmpty {
                getField(.orderId, content: orderId)
            }
            
            // 票號 (UC)
            if let qppTicketId = data.qppTicketId, !qppTicketId.isEmpty {
                getField(.qppTicketId, content: qppTicketId)
            }
        }
    }
    
    /// 取得欄位
    func getField(_ field: Field, content: String) -> some View {
        HStack(spacing: titleToContentPadding) {
            // 標題
            Text(field.rawValue)
                .textStyle(titleTextStyle)
                .frame(maxWidth: 80, alignment: .leading)
            
            // 內容
            Text(content)
                .textStyle(contentTextStyle)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    TicketFieldInfo(data: .fakeData, titleToContentPadding: 20, titleTextStyle: .mobileBody3_grayScale500, contentTextStyle: .mobileBody1_grayScale700)
        .environmentObject(AppState.shared)
}
