//
//  ActivityListViewModel.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/23.
//

import SwiftUI

let serverLoadMoreInitPage = 1

class ActivityListViewModel: ObservableObject {
    
    @Published var getActiveListResponse: GetActiveListResponse? = nil
    private(set) var error: Error? = nil {
        didSet {
            if error != nil {
                shouldShowToast = true
            }
        }
    }
    
    /// 記錄要位移的位置
    @Published var scrollPostionY: CGFloat?
    /// 通知滾輪樣式要強制更新的變數
    @Published var contentOffset: CGPoint?
    
    @Published var shouldShowToast: Bool = false
    
    // 續撈狀態
    @Published var loadingState: LoadMoreView.LoadingState = .loading(page: serverLoadMoreInitPage)
    // 是否為刷新
    private var isRefresh = false
    
    deinit {
        print("deinit: \(self)")
    }
    
    /// 取得活動清單
    /// - Parameters:
    ///   - page: 第幾頁
    ///   - take: 一頁幾筆
    func getActiveList(page: Int, take: Int = 10) {
//        let request = GetActiveListAPIRequest(page: page, take: take)
        
        Task { [weak self] in
            do {
//                let response: GetActiveListResponse = try await NetworkManager.shared.requestData(apiRequest: request, showIndicator: false)
                
                var datas: [GetActiveListResponse.ActiveData] {
                    if page == 1 {
                        (1 ... 10).map {
                            GetActiveListResponse.ActiveData.createFakeData($0)
                        }
                    } else {
                        (11 ... 20).map {
                            GetActiveListResponse.ActiveData.createFakeData($0)
                        }
                    }
                }
                
                let response: GetActiveListResponse = .init(datas: datas, totalItems: 20, totalPages: 2)
                
                await Task.sleep(for: 1) // 模擬 API 等待
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    self.error = nil
                    
                    var updatedResponse = self.getActiveListResponse
                    
                    // 為了讓下拉刷新不清空資料(會閃一下)，所以判斷 isRefresh 去做資料覆蓋
                    if self.isRefresh {
                        self.isRefresh = false
                        self.getActiveListResponse = response
                    } else {
                        updatedResponse?.datas += response.datas
                        self.getActiveListResponse = updatedResponse ?? response
                    }
                    
                    self.loadingState = .success(nextPage: page * take >= response.totalItems ? nil : page + 1)
                }
            } 
//            catch {
//                await MainActor.run { [weak self] in
//                    self?.error = error
//                    self?.loadingState = .fail(retryPage: page)
//                }
//            }
        }
    }
    
    /// 刷新
    func refresh() {
        isRefresh = true
        getActiveList(page: serverLoadMoreInitPage)
    }
}
