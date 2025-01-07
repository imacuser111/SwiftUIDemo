//
//  WKTextField.swift
//  TestSwiftUI
//
//  Created by mike on 2024/10/7.
//

import SwiftUI

/// UIKit textField
struct WKTextField: UIViewRepresentable {
    
    @EnvironmentObject private var appState: AppState
    
    private var text : Binding<String>
    
    private var textStyle: CTextStyle
    private var placeholder : String
    private var placeholderStyle: CTextStyle
    private var isSecureTextEntry: Bool

    private var keyboardType: UIKeyboardType?
    private let returnKeyType: UIReturnKeyType
    
    
    /// 點擊完成按鈕
    var onTextFieldShouldReturn: (() -> Void)?
    /// 文字變動時，回傳調整後的字串。
    var onTextFieldModifyText: ((String) -> String)
    
    
    init(
        _ text: Binding<String>,
        textStyle: CTextStyle = .mobileBody2_grayScale900,
        placeholder: String = "",
        placeholderStyle: CTextStyle = .mobileBody2_grayScale300,
        isSecureTextEntry: Bool = false,
        keyboardType: UIKeyboardType? = nil,
        returnKeyType: UIReturnKeyType = .default,
        onTextFieldModifyText: @escaping ((String) -> String) = { $0 },
        onTextFieldShouldReturn: (() -> Void)? = nil
    ) {
        self.text = text
        self.textStyle = textStyle
        self.placeholder = placeholder
        self.placeholderStyle = placeholderStyle
        self.isSecureTextEntry = isSecureTextEntry
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        
        self.onTextFieldModifyText = onTextFieldModifyText
        self.onTextFieldShouldReturn = onTextFieldShouldReturn
    }
    
    func makeCoordinator() -> WKTextField.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<WKTextField>) -> UITextField {
        
        let textField = UITextField(frame: .zero)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.isSelected = false
        textField.addDoneToolBar()
        textField.delegate = context.coordinator
        
        context.coordinator.setup(textField)
        
        updateUIView(textField, context: context)
        
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: UIViewRepresentableContext<WKTextField>) {
    
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(placeholderStyle.color(appState.theme.colorTheme)),
                NSAttributedString.Key.font:
                    placeholderStyle.uiFont
            ]
        )
        textField.text = text.wrappedValue
        textField.textColor = UIColor(textStyle.color(appState.theme.colorTheme))
        textField.font = textStyle.uiFont
        textField.isSecureTextEntry = isSecureTextEntry
        textField.returnKeyType = returnKeyType
        textField.keyboardType = keyboardType ?? .default
        
        context.coordinator.updateParent(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: WKTextField
        
        init(_ parent: WKTextField) {
            self.parent = parent
        }
        
        func updateParent(_ parent : WKTextField) {
            self.parent = parent
        }
        
        func setup(_ textField:UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onTextFieldShouldReturn?()
            return true
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            
            let result = parent.onTextFieldModifyText(textField.text ?? "")
            
            textField.text = result
            parent.text.wrappedValue = result
            
            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
}

#Preview {
    WKTextField(.constant("Hello"))
        .environmentObject(AppState.shared)
}
