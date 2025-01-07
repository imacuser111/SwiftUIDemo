//
//  GeneralAlert.swift
//  GashTickets
//
//  Created by Cheng-Hong on 2024/10/4.
//

import SwiftUI

/// 一般的Alert
struct GeneralAlert: BaseAlertView {
    
    /// The alert type being shown
    let alertType: AlertType
    
    var actions: (AlertAction) -> Void
    
    
    var body: some View {
        
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                
                if let image = alertType.image {
                    Image(image)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .padding(.top, 10)
                        .padding(.bottom, 34)
                        .frame(width: 100)
                }
            
                // alert title
                Text(alertType.title)
                    .textStyle(.mobileH1_grayScale1000)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                
                // alert message
                Text(alertType.message)
                    .textStyle(.mobileBody1_grayScale1000)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                
                VStack(spacing: 18) {
                    Button {
                        actions(.confirm)
                    } label: {
                        Text(alertType.confirmActionText)
                    }
                    .styleButton(.oval(type: .secondary))
                    .frame(height: 40)
                    
                    if let cancelActionText = alertType.cancelActionText {
                        Button {
                            actions(.cancel)
                        } label: {
                            Text(cancelActionText)
                        }
                        .styleButton(.none(type: .cancel))
                        .frame(height: 40)
                    }
                }
            }
            .padding(.vertical, 32)
        }
        .padding(.horizontal, 32)
        .frame(width: 350)
        .roundedReactBackground(cornerRadius: 20, fill: { $0.colorTheme.colorsGrayScale0 })
    }
}

#Preview {
    ZStack {
        GeneralAlert(alertType: .normal(
            title: "標題",
            message: "訊息",
            confirmActionText: "確認",
            cancelActionText: "取消",
            iconStyle: .success
        ), actions: { _ in })
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
}

