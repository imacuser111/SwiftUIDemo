//
//  Codable+.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/22.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
       
        return dictionary
    }
}

extension Array {
    var jsonString: String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return ""
        }
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
    }
}
