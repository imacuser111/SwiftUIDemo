//
//  GetActiveList.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/23.
//

import Foundation

/// 取得活動資訊
struct GetActiveListAPIRequest: APIRequest {
    
    let method: NetworkConstants.HTTPMethod = .POST
    
    let path: NetworkConstants.ApiPathConstants = .GetActiveList
    
    let body: Encodable
    
    let contentType: NetworkConstants.ContentType = .json
    
    /// 初始化
    /// - Parameters:
    ///   - page: 第幾頁
    ///   - take: 一頁幾筆
    init(page: Int, take: Int) {
        let request = GetActiveListRequest(page: page, take: take)
        body = request
    }
}

private struct GetActiveListRequest: Encodable {
    /// 第幾頁
    let page: Int
    /// 一頁幾筆
    let take: Int
}

struct GetActiveListResponse: Decodable {
    var datas: [ActiveData]
    let totalItems: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case datas = "Datas"
        case totalItems = "TotalItems"
        case totalPages = "TotalPages"
    }
}

extension GetActiveListResponse {
    /// 活動資料
    struct ActiveData: Decodable, Identifiable, Equatable {
        var id: Int { active_sn }
        
        /// 編號
        let active_sn: Int
        /// 名稱
        let active_name: String
        /// 圖片
        let active_img: String
        /// 背景圖
        let background_img: String
        
        
        static var fakeData: Self {
            .init(active_sn: 0,
                  active_name: "假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假資料假結束",
                  active_img: "https://storage.googleapis.com/stage-ticketupload-gash/activity/4d86700900f71789b2d9a999ad726639.webp",
                  background_img: "https://storage.googleapis.com/stage-ticketupload-gash/activity/c98f34cf431eb83055559b5123f2ac69.webp")
        }
        
        static func createFakeData(_ index: Int) -> Self {
            .init(active_sn: index,
                  active_name: "標題＿\(index)",
                  active_img: "https://storage.googleapis.com/stage-ticketupload-gash/activity/4d86700900f71789b2d9a999ad726639.webp",
                  background_img: "https://storage.googleapis.com/stage-ticketupload-gash/activity/c98f34cf431eb83055559b5123f2ac69.webp")
        }
        
        static var fakeDatas: [Self] {
            var array: [Self] = []
            for index in 0..<10 {
                array.append(createFakeData(index))
            }
            return array
        }
    }
}
