//
//  UITextField+Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/11/30.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
protocol InputAccessoryProtocol {
    func addAccessoryView()->Void
}
extension UITextField : InputAccessoryProtocol{
    func addAccessoryView() {
        inputAccessoryView = accessoryView
    }
}
extension UITextView  : InputAccessoryProtocol{
    func addAccessoryView() {
        inputAccessoryView = accessoryView
    }
}
extension UISearchBar : InputAccessoryProtocol{
    func addAccessoryView() {
        inputAccessoryView = accessoryView
    }
}

extension InputAccessoryProtocol{

  fileprivate var accessoryView : UIView{
        
        let lineHeight = 0.7
        let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width.double, height: 40.0))
        view.backgroundColor = UIColor.white
    
        let topLine = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width.double, height:lineHeight))
        topLine.backgroundColor = UIColor.hex(hexValue: 0xE5E5E5)
        view.addSubview(topLine)
        
        let buttonWidth    = 36.0
        let completeButton = UIButton.init(type: .custom)
        completeButton.frame = CGRect.init(x: view.width.double - 10 - buttonWidth, y: 0, width: buttonWidth, height: buttonWidth)
        completeButton.centerY = view.height/2.0
        completeButton.setTitle("完成", for: .normal)
        completeButton.setTitleColor(APP.textMainColor, for: .normal)
        completeButton.setTitleColor(UIColor.hex(hexValue: 0x999999), for: .highlighted)
        completeButton.titleLabel?.font = UIFont.size14
        completeButton.addAction { (button) in
            APP.keyWindow.endEditing(true)
        }
        view.addSubview(completeButton)
        
        let bottomLine = UIView.init(frame: CGRect.init(x: 0, y: view.height.double - lineHeight, width: UIScreen.main.bounds.width.double, height: lineHeight))
        bottomLine.backgroundColor = UIColor.hex(hexValue: 0xE5E5E5)
        view.addSubview(bottomLine)
        
        return view
    }
}



