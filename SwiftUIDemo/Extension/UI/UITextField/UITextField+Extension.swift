//
//  UITextField+Extension.swift
//  TestSwiftUI
//
//  Created by mike on 2024/10/7.
//

import SwiftUI

extension UITextField {
    
    /// 新增右上角的完成按鈕
    internal func addDoneToolBar() {
        var itemArray = [UIBarButtonItem]()
        itemArray.append(self.addFlexibleSpaceBtn())
        itemArray.append(self.addDoneButton())
        //toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems(itemArray, animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    internal func addDoneButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .done,
                               target: self,
                               action: #selector(doneBtnPressed))
    }
    
    internal func addFlexibleSpaceBtn() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                               target: nil,
                               action: nil)
    }
    
    @objc func doneBtnPressed() {
        self.endEditing(true)
    }
}
