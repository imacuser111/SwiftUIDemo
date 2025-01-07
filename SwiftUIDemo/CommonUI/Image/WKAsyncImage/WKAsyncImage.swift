//
//  WKAsyncImage.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/24.
//

import SwiftUI

extension URLSession {
    // 創建與配置圖片 Cache 的 URLSession
    static let imageSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = .imageCache
        
        return .init(configuration: config)
    }()
}

extension URLCache {
    // 設定 Cache 的大小
    static let imageCache: URLCache = {
        .init(memoryCapacity: 20 * 1024 * 1024,
              diskCapacity: 30 * 1024 * 1024)
    }()
}

/// 帶有 Cache 的 AsyncImage
struct WKAsyncImage: View {
    // 這邊若沒有用 @ObservedObject iOS 16.1 ~ 16.3 會抓到錯的圖片
    @ObservedObject private var viewModel: WKAsyncImageViewModel
    
    init(url: String, session: URLSession = .imageSession) {
        self._viewModel = .init(wrappedValue: .init(url: url, session: session))
    }
    
    var body: some View {
        Group {
            switch viewModel.phase {
            case .empty:
                ProgressView()
                    .scaleEffect(2)
                    .task { await viewModel.load() }
            case .success(let image):
                image
                    .resizable()
            case .failure:
                EmptyView()
            @unknown default:
#if DEV
                fatalError("This has not been implemented.")
#else
                EmptyView()
#endif
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Demo

/// 下載圖片 Screen(Demo用)
struct AsyncImageDemoScreen: View {
    @State private var id: UUID = UUID()
    let url = "https://images.unsplash.com/photo-1678880032033-d954b408963c?width=300"
    
    var body: some View {
        VStack {
            titleView
//            AsyncImage(url: URL(string: url)!)
            WKAsyncImage(url: url).id(id)
                .frame(height: 300)
            
            Button("重新整理") {
                id = UUID()
            }
        }
    }
}

extension AsyncImageDemoScreen {
    var titleView: some View {
        Text("AsyncImage Demo")
            .font(.largeTitle.bold())
    }
}


struct AsyncImageDemoScreen_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageDemoScreen()
    }
}
