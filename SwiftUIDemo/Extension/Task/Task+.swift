//
//  Task+.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/16.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    // 定義一個靜態方法來執行延遲
    static func sleep(for seconds: Double) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                continuation.resume()
            }
        }
    }
}
