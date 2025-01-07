//
//  APIRequest.swift
//  NewTalk
//
//  Created by hsu tzu Hsuan on 2020/8/19.


import Foundation

/// API 請求需要帶的相關參數
protocol APIRequest {
    
    var method: NetworkConstants.HTTPMethod { get }
    
    var path: NetworkConstants.ApiPathConstants { get }
    
    var body: Encodable { get }
    
    var contentType: NetworkConstants.ContentType { get }
}

extension APIRequest {
    
    /// 要求
    /// - Parameter baseURL: 連線的url
    /// - Returns: 回傳該api的資料
    func request(with baseURL: URL) -> URLRequest {
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path.rawValue))
        urlRequest.timeoutInterval = 15
        urlRequest.httpMethod = method.rawValue
        
        // 登入與是否強版更這兩道不需要新增 base request
        if path == .Login || path == .IsForceUpdate {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try? encoder.encode(body)
        } else {
            let dict1 = try? BaseRequest(partner: AppState.shared.partner,
                                         member_id: AppState.shared.memberId,
                                         token: AppState.shared.token).asDictionary()
            var dict2 = try? body.asDictionary()
            
            // 將 base 內容合併至 request
            dict1?.forEach { dict2?[$0] = $1 }
            
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: dict2 ?? [:], options: .prettyPrinted)
        }
        
        // 加入額外參數
        if let addValues = contentType.addValues {
            for (value, forHTTPHeaderField) in addValues {
                urlRequest.addValue(value, forHTTPHeaderField: forHTTPHeaderField)
            }
        }
        
        urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
