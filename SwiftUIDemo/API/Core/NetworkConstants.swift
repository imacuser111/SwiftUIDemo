//
//  File.swift
//  BasicStructure
//
//  Created by CINHONG on 2019/3/29.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    static var baseURL: URL {
        #if DEBUG
        URL(string: "https://stage-tickets-ticketapi.funone.io/api/ForQpp/")! // 測試
        #else
        URL(string: "https://tickets-ticketapi.funone.io/api/ForQpp/")! // 正式
        #endif
    }
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType {
        case json
        case formData(boundary: String, addValues: [String: String])
            
        var rawValue: String {
            switch self {
            case .json:
                return "application/json"
            case .formData(let boundary, _):
                return "multipart/form-data; boundary=\(boundary)"
            }
        }
        
        var addValues: [String: String]? {
            switch self {
            case .json:
                return nil
            case .formData(_, let addValues):
                return addValues
            }
        }
    }
}

extension NetworkConstants {
    enum HTTPMethod: String {
        case GET, POST, HEAD
    }
    
    enum ApiPathConstants: String {
        case Login
        case GetActiveList
        case GetRoundList
        case GetTicketData
        case CutTicket
        case GetCutHistoryList
        case IsForceUpdate
    }
}
