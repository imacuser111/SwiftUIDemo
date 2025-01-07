//
//  ToastView.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/9/20.
//

import SwiftUI

enum ToastType {
    case `default`
    case success
    case error
}

struct ToastView: View {
    @Binding var isShow: Bool
    @State private var isShowAnimation: Bool = true
    @State private var duration : Double
    
    let info: String
    let type: ToastType
    
    init(isShow: Binding<Bool>, info: String, type: ToastType, duration: Double) {
        self._isShow = isShow
        self.info = info
        self.type = type
        self.duration = duration
    }
    
    var body: some View {
        ZStack {
            Text(info)
                .textStyle(.mobileCpation_grayScale150)
//                .frame(minWidth: 80, minHeight: 30)
                .zIndex(1.0)
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
                .roundedReactBackground(cornerRadius: 20) {
                    switch type {
                    case .default:
                        $0.colorTheme.colorsGrayScale1000
                            .opacity(0.8)
                    case .success:
                        $0.colorTheme.colorsSuccess600
                            .opacity(0.9)
                    case .error:
                        $0.colorTheme.colorsError500
                            .opacity(0.8)
                    }
                }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                isShowAnimation = false
            }
        }
        .padding(.bottom, 50)
        .opacity(isShowAnimation ? 1 : 0)
        .animation(.easeIn(duration: 0.8), value: isShowAnimation)
        .edgesIgnoringSafeArea(.all)
        .onChange(of: isShowAnimation) { e in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.isShow = false
            }
        }
    }
}

extension View {
    func toast(isShow: Binding<Bool>, info: String, type: ToastType = .default, duration: Double = 1.0) -> some View {
        ZStack {
            self
            if isShow.wrappedValue && !info.isEmpty {
                VStack {
                    Spacer()
                    ToastView(isShow: isShow, info: info, type: type, duration: duration)
                }
            }
        }
    }
}

#Preview {
    EmptyView()
        .toast(isShow: .constant(true), info: "Test")
        .environmentObject(AppState.shared)
}
