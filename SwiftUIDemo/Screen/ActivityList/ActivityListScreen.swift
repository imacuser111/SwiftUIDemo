//
//  ActivityListScreen.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/17.
//

import SwiftUI

/// 活動清單
struct ActivityListScreen: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ActivityListViewModel()
    
    @State private var isPresented: Bool = false
    @State private var selectedData: GetActiveListResponse.ActiveData?
    
    var body: some View {
        WKNavigation {
            ScrollView {
                RefreshableView {
                    LazyVStack(spacing: 16) {
                        Text("可下拉刷新⬆️")
                        Button("跳頁") {
                            AppState.shared.hiddenTabBar()
                            isPresented = true
                        }
                        
                        ForEach(viewModel.getActiveListResponse?.datas ?? [], id: \.active_sn) { data in
                            EventTitle(data: data)
                                .clipShape(.rect(cornerRadius: 8))
                                .padding(.horizontal, 16)
                        }
                        
                        // 續撈
                        LoadMoreView(loadingState: $viewModel.loadingState) { [weak viewModel] page in
                            // 一般
                            viewModel?.getActiveList(page: page)
                        }
                    }
                    .padding(.vertical, 20)
                }
            }
            .refreshable { [weak viewModel] in
                // API太快了，延遲一下讓下拉刷新動畫顯示
                await Task.sleep(for: 1)
                
                viewModel?.refresh()
            }
            .background { $0.theme.colorTheme.colorsGrayScale50 }
            .primaryNavigationBar(title: LocalizationList.ID_ActivityList)
            ._navigationDestination(isPresented: $isPresented) {
                ContentView()
            }
        }
        .toast(isShow: $viewModel.shouldShowToast, info: viewModel.error?.errorDescription ?? "", type: .error)
    }
}

#Preview {
    ActivityListScreen()
        .environmentObject(AppState.shared)
}
