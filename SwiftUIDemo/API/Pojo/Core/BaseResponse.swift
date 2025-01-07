//
//  BaseResponse.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/21.
//

import Foundation

struct BaseResponse<D: Decodable>: Decodable {
    let isSuccess: Bool
    let message: String
    let value: D
    let spend: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "IsSuccess"
        case message = "Message"
        case value = "Value"
        case spend = "Spend"
    }
}
