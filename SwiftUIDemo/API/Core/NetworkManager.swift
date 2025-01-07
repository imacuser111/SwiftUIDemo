//
//  NetworkManager.swift
//  GashTickets
//
//  Created by CINHONG on 2024/8/5.
//

import UIKit
class NetworkManager: NSObject, URLSessionDelegate {
    
    static let shared = NetworkManager()
    
    /// 請求數據
    internal func requestData<D: Decodable>(url: URL = NetworkConstants.baseURL,
                                            apiRequest: APIRequest,
                                            showIndicator: Bool = true) async throws -> D {
        // 開啟進度視圖
        await self.shouldShowProgressView(true, showIndicator: showIndicator)
        
        let urlRequest = apiRequest.request(with: url)
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    
                    if let results = try? decoder.decode(BaseResponse<D>.self, from: data) {
                        self.printNetworkProgress(urlRequest, apiRequest.body, results)
                        
                        if results.isSuccess {
                            // 關閉進度視圖
                            await self.shouldShowProgressView(false, showIndicator: showIndicator)
                            return results.value
                        } else {
                            // isSuccess 為 false，顯示 Server message
                            throw GashTicketsError.responseFailed(reason: .serverFeedbackError(errorCode: -1, failString: results.message))
                        }
                    } else {
                        // 無法解析數據
                        throw GashTicketsError.responseFailed(reason: .dataParsingFailed(D.self, data, nil))
                    }
                default:
                    throw GashTicketsError.generalError(reason: .httpError(errorCode: httpResponse.statusCode))
                }
            } else {
                throw GashTicketsError.responseFailed(reason: .nonHTTPURLResponse(nil))
            }
        } catch {
            self.printNetworkError(urlRequest, apiRequest.body, error)
            // 關閉進度視圖
            await self.shouldShowProgressView(false, showIndicator: showIndicator)
            
            throw error
        }
    }
    
    // 是否顯示 ProgressView
    private func shouldShowProgressView(_ shouldShow: Bool, showIndicator: Bool) async {
        if showIndicator {
            await MainActor.run {
                shouldShow ? AppState.shared.showProgressView() : AppState.shared.hiddenProgressView()
            }
        }
    }
    
    private func printNetworkProgress<E: Encodable, D: Decodable>(_ urlRequest: URLRequest, _ parameters: E, _ results: D) {
        print("=======================================")
        print("- URL: \(urlRequest.url?.absoluteString ?? "")")
        print("- Header: \(urlRequest.allHTTPHeaderFields ?? [:])")
        print("---------------Request-----------------")
        print(parameters)
        print("---------------Response----------------")
        print(results)
        print("=======================================")
    }
    
    private func printNetworkError<E: Encodable>(_ urlRequest: URLRequest, _ parameters: E, _ error: Error) {
        print("=======================================")
        print("- URL: \(urlRequest.url?.absoluteString ?? "")")
        print("- Header: \(urlRequest.allHTTPHeaderFields ?? [:])")
        print("---------------Request-----------------")
        print(parameters)
        print("----------------Error------------------")
        print(error)
        print("=======================================")
    }
}
