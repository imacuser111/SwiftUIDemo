//
//  KeyboardAdaptive.swift
//  GashTickets
//
//  Created by mike on 2024/10/17.
//

import Combine
import SwiftUI

/// 鍵盤自適應
/// 主要是放在最外層 View (非 ScrollView)，當鍵盤彈出時，會做 offset 位移。
/// 此 View or 最外層的 View 要加 ignoresSafeArea 屬性，避免 swiftUI 自動幫你鍵盤位移。
struct KeyboardAdaptiveModifier: ViewModifier {
    
    @Environment(\.screenSize) var screenSize
    
    @State private var bottomPadding: CGFloat = 0
    
    /// 是否正在動畫中
    @State private var isOnAnimation = false
    
    @State private var focusedTextInputBottom: CGFloat = 0
    
    
    func body(content: Content) -> some View {
        
        content
            .offset(y: -self.bottomPadding)
            .onAnimationCompleted(for: bottomPadding) {
                isOnAnimation = false
            }
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                
                // 高度為0，直接重置偏移量。
                if keyboardHeight == 0 {
                    self.bottomPadding = 0
                    return
                }
                
                let keyboardTop = screenSize.screenHeight - keyboardHeight
                let focusedTextInputBottom = self.isOnAnimation ? self.focusedTextInputBottom : UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                let bottomPadding = max(0, focusedTextInputBottom - keyboardTop) + (self.isOnAnimation ? self.bottomPadding : 0)
            
                if self.bottomPadding < bottomPadding {
                    
                    // 開始移動動畫
                    self.focusedTextInputBottom = focusedTextInputBottom - bottomPadding
                    self.isOnAnimation = true
                    
                    withAnimation(.interpolatingSpring(mass: 3, stiffness: 1000, damping: 500, initialVelocity: 0)) {
                        self.bottomPadding = bottomPadding
                    }
                }
            }
    }
}

// MARK: extension View
extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptiveModifier())
    }
}

// MARK: extension Publishers
extension Publishers {
    
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide).eraseToAnyPublisher()
    }
}

// MARK: extension Notification
extension Notification {
    
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

// MARK: extension UIResponder
extension UIResponder {
    
    private static weak var _currentFirstResponder: UIResponder?
    
    
    var globalFrame: CGRect? {
        guard let view = self as? UIView else {
            return nil
        }
        return view.superview?.convert(view.frame, to: nil)
    }
    
    
    static var currentFirstResponder: UIResponder? {
        
        _currentFirstResponder = nil
        
        // 重新取得響應者
        UIApplication.shared.sendAction(
            #selector(UIResponder.findFirstResponder(_:)),
            to: nil,
            from: nil,
            for: nil
        )
        
        return _currentFirstResponder
    }

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}

