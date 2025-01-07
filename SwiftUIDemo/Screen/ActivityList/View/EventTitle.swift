//
//  EventTitle.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/23.
//

import SwiftUI

/// 活動清單 cell、選擇場次 Header
struct EventTitle: View {
    
    private let isStickyHeaderVisible: Bool
    
    let data: GetActiveListResponse.ActiveData
    
    init(data: GetActiveListResponse.ActiveData, isStickyHeaderVisible: Bool = false) {
        self.data = data
        self.isStickyHeaderVisible = isStickyHeaderVisible
    }
    
    var body: some View {
        Group {
            if isStickyHeaderVisible {
                title
            } else {
                HStack(alignment: .top) {
                    WKAsyncImage(url: data.active_img)
                        .aspectRatio(9 / 12, contentMode: .fit)
                        .frame(width: 90)
                        .clipShape(.rect(cornerRadius: 8))
                        .padding(.trailing, 16)
                    
                    title
                        .padding(.top, 8)
                }
            }
        }
        .padding(.vertical, isStickyHeaderVisible ? 16 : 26)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(
            ZStack {
                GeometryReader { geometry in
                    // 背景圖
                    WKAsyncImage(url: data.background_img)
                        .scaledToFill()  // 填滿父容器
                        .frame(width: geometry.size.width, height: geometry.size.height)  // 讓圖片的寬高跟隨視圖
                        .blur(radius: 20) // 添加模糊效果，數值越高模糊越強
                        .clipped()       // 防止圖片溢出邊界
                    
                    // 遮罩
                    Color.black.opacity(0.3)
                }
            }
        )
    }
}

private extension EventTitle {
    var title: some View {
        Text(data.active_name)
            .lineLimit(isStickyHeaderVisible ? 1 : nil)
            .multilineTextAlignment(.leading)
            .textStyle(.mobileH4_grayScale0)
    }
}

#Preview {
    EventTitle(data: .fakeData)
        .environmentObject(AppState.shared)
}
