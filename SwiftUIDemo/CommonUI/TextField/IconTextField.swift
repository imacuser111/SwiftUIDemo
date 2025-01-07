//
//  LoginTextField.swift
//  TestSwiftUI
//
//  Created by mike on 2024/10/1.
//

import SwiftUI

/// 輸入框左右兩邊有 icon 顯示 (不包含邊框)
struct IconTextField: View {
    
    /// 結尾圖片點擊
    private var onImageTap: ((IconStyle) -> Void)?
    
    /// 左邊圖片
    private var leadingImages: [IconStyle]
    /// 結尾圖片
    private var trailingImages: [IconStyle]
    
    /// 內容
    private var content: () -> WKTextField
    
    init(
        leadingImages: [IconStyle] = [],
        trailingImages: [IconStyle] = [],
        onImageTap: ((IconStyle) -> Void)? = nil,
        content: @escaping () -> WKTextField
    ) {
        self.leadingImages = leadingImages
        self.trailingImages = trailingImages
        self.onImageTap = onImageTap
        self.content = content
    }

    var body: some View {
        
        HStack(spacing: 0) {
            
            if !leadingImages.isEmpty {
                createImages(leadingImages, isLeading: true)
            }
            
            content()
            
            if !trailingImages.isEmpty {
                createImages(trailingImages, isLeading: false)
            }
        }
    }
    
    /// 生產圖片元件
    func createImages(_ images: [IconStyle], isLeading: Bool) -> some View {
        
        ForEach(images, id: \.self) { item in
            HStack(spacing: 0) {
                
                WKImageView(item.image, modifiers: { $0.resizable() })
                    .frame(width: item.size.width, height: item.size.height)
                    .padding(.leading, isLeading ? 0 : item.padding)
                    .padding(.trailing, isLeading ? item.padding : 0)
                    .onTapGesture {
                        onImageTap?(item)
                    }
            }
        }
    }
}

// MARK: 變數處理
extension IconTextField {
    
    /// 宣告的類型樣式
    enum IconStyle: Hashable {
        
        typealias Style = Self
        
        /// 搜尋
        case search
        /// 密碼
        case password(isPasswordVisble: Bool)
        
        
        /// 圖片
        var image: ImageThemeCallBack {
            switch self {
            case .search:
                return { $0.iconsSearch }
            case .password(let isPasswordVisble):
                return { isPasswordVisble ? $0.iconsEyeOpen : $0.iconsEyeClose }
            }
        }
        
        /// 間距
        var padding: CGFloat {
            8
        }
        
        /// 尺寸
        var size: CGSize {
            .init(width: 22, height: 22)
        }
    }
}
 

#Preview {
    IconTextField(trailingImages: [.search]) {
        WKTextField(
            .constant(""),
            placeholder: "123"
        )
    }
    .environmentObject(AppState.shared)
}
