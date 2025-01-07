//
//  LoadMoreView.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/24.
//

import SwiftUI

/// 續撈元件
struct LoadMoreView: View {
    
    enum LoadingState: Equatable {
        case loading(page: Int)
        case success(nextPage: Int?)
        case fail(retryPage: Int)
        
        /// 是否已經完全加載
        var isDataFullyLoaded: Bool {
            self == .success(nextPage: nil)
        }
        
        /// 是否為第一次失敗
        var isFristFail: Bool {
            self == .fail(retryPage: serverLoadMoreInitPage)
        }
    }
    
    @Binding var loadingState: LoadingState
    
    let loadData: (_ page: Int) -> ()
    
    var body: some View {
        Group {
            switch loadingState {
            case .loading(let page):
                ProgressView()
                    .onAppear {
                        loadData(page)
                    }
            case .success(let nextPage?):
                ProgressView()
                    .onAppear {
                        loadData(nextPage)
                    }
            case .fail(let retryPage):
                AppearEmptyView {
                    loadData(retryPage)
                }
            default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}
