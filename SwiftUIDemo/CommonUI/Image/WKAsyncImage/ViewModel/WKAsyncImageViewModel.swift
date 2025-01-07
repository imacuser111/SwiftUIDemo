//
//  WKAsyncImageViewModel.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/12/16.
//

import SwiftUI

// 由於只在外面使用 @State 會導致 iOS 16.1 ~ 16.3 抓到錯的圖片
// 因此創個 ViewModel 讓外面使用 @ObservedObject 去重新 init
class WKAsyncImageViewModel: ObservableObject {
    // 需要設定 @ObservedObject 讓他重新 init()
    @Published var phase: AsyncImagePhase = .empty
    
    private let session: URLSession
    private let urlRequest: URLRequest?
    
    deinit {
        print("deinit: \(self)")
    }
    
    init(url: String, session: URLSession) {
        self.session = session
        
        if let url = URL(string: url) {
            let urlRequest = URLRequest(url: url)
            self.urlRequest = urlRequest
            
            if let data = session.configuration.urlCache?.cachedResponse(for: urlRequest)?.data,
               let uiImage = UIImage(data: data) {
                phase = .success(.init(uiImage: uiImage))
            }
        } else {
            urlRequest = nil
        }
        
    }
    
    func load() async {
        do {
            guard let urlRequest else { return }
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode,
                  let uiImage = UIImage(data: data)
            else {
                throw URLError(.unknown)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.phase = .success(.init(uiImage: uiImage))
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.phase = .failure(error)
            }
        }
    }
}
