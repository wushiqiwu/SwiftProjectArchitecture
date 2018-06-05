//
//  UITextField+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension LinkCreator where Base : UITextField{
    
    @discardableResult
    public func text(_ value: String?) -> LinkCreator {
        base.text = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func attributedText(_ value: NSAttributedString?) -> LinkCreator {
        base.attributedText = value
        return self
    }
    
    @discardableResult
    public func textColor(_ value: UIColor?) -> LinkCreator {
        base.textColor = value
        return self
    }
    
    @discardableResult
    public func font(_ value: UIFont?) -> LinkCreator {
        base.font = value
        return self
    }
    
    @discardableResult
    public func textAlignment(_ value: NSTextAlignment) -> LinkCreator {
        base.textAlignment = value
        return self
    }
    
    @discardableResult
    public func borderStyle(_ value: UITextBorderStyle) -> LinkCreator {
        base.borderStyle = value
        return self
    }
    
    @available(iOS 7.0, *)
    @discardableResult
    public func defaultTextAttributes(_ value: [String : AnyObject]) -> LinkCreator {
        base.defaultTextAttributes = value
        return self
    }
    
    @discardableResult
    public func placeholder(_ value: String?) -> LinkCreator {
        base.placeholder = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func attributedPlaceholder(_ value: NSAttributedString?) -> LinkCreator {
        base.attributedPlaceholder = value
        return self
    }
    
    @discardableResult
    public func clearsOnBeginEditing(_ value: Bool) -> LinkCreator {
        base.clearsOnBeginEditing = value
        return self
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool) -> LinkCreator {
        base.adjustsFontSizeToFitWidth = value
        return self
    }
    
    @discardableResult
    public func minimumFontSize(_ value: CGFloat) -> LinkCreator {
        base.minimumFontSize = value
        return self
    }
    
    @discardableResult
    public func delegate(_ value: UITextFieldDelegate?) -> LinkCreator {
        base.delegate = value
        return self
    }
    
    @discardableResult
    public func background(_ value: UIImage?) -> LinkCreator {
        base.background = value
        return self
    }
    
    @discardableResult
    public func disabledBackground(_ value: UIImage?) -> LinkCreator {
        base.disabledBackground = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func allowsEditingTextAttributes(_ value: Bool) -> LinkCreator {
        base.allowsEditingTextAttributes = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func typingAttributes(_ value: [String : AnyObject]?) -> LinkCreator {
        base.typingAttributes = value
        return self
    }
    
    @discardableResult
    public func clearButtonMode(_ value: UITextFieldViewMode) -> LinkCreator {
        base.clearButtonMode = value
        return self
    }
    
    @discardableResult
    public func leftView(_ value: UIView?) -> LinkCreator {
        base.leftView = value
        return self
    }
    
    @discardableResult
    public func leftViewMode(_ value: UITextFieldViewMode) -> LinkCreator {
        base.leftViewMode = value
        return self
    }
    
    @discardableResult
    public func rightView(_ value: UIView?) -> LinkCreator {
        base.rightView = value
        return self
    }
    
    @discardableResult
    public func rightViewMode(_ value: UITextFieldViewMode) -> LinkCreator {
        base.rightViewMode = value
        return self
    }
    
    @discardableResult
    public func inputView(_ value: UIView?) -> LinkCreator {
        base.inputView = value
        return self
    }
    
    @discardableResult
    public func inputAccessoryView(_ value: UIView?) -> LinkCreator {
        base.inputAccessoryView = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func clearsOnInsertion(_ value: Bool) -> LinkCreator {
        base.clearsOnInsertion = value
        return self
    }
}

