//
//  UITextView+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension LinkCreator where Base : UITextView{
    
    @discardableResult
    public func text(_ value: String!) -> LinkCreator {
        base.text = value
        return self
    }
    
    @discardableResult
    public func font(_ value: UIFont?) -> LinkCreator {
        base.font = value
        return self
    }
    
    @discardableResult
    public func textColor(_ value: UIColor?) -> LinkCreator {
        base.textColor = value
        return self
    }
    
    // default is NSLeftTextAlignment
    @discardableResult
    public func textAlignment(_ value: NSTextAlignment) -> LinkCreator {
        base.textAlignment = value
        return self
    }
    
    @discardableResult
    public func selectedRange(_ value: NSRange) -> LinkCreator {
        base.selectedRange = value
        return self
    }
    
    @discardableResult
    public func editable(_ value: Bool) -> LinkCreator {
        base.isEditable = value
        return self
    }
    
    // toggle selectability, which controls the ability of the user to select content and interact with URLs & attachments
    @available(iOS 7.0, *)
    @discardableResult
    public func selectable(_ value: Bool) -> LinkCreator {
        base.isSelectable = value
        return self
    }
    
    @available(iOS 3.0, *)
    @discardableResult
    public func dataDetectorTypes(_ value: UIDataDetectorTypes) -> LinkCreator {
        base.dataDetectorTypes = value
        return self
    }
    
    // defaults to NO
    @available(iOS 6.0, *)
    @discardableResult
    public func allowsEditingTextAttributes(_ value: Bool) -> LinkCreator {
        base.allowsEditingTextAttributes = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func attributedText(_ value: NSAttributedString!) -> LinkCreator {
        base.attributedText = value
        return self
    }
    
    // automatically resets when the selection changes
    @available(iOS 6.0, *)
    @discardableResult
    public func typingAttributes(_ value: [String : AnyObject]) -> LinkCreator {
        base.typingAttributes = value
        return self
    }
    
    // Presented when object becomes first responder.  If set to nil, reverts to following responder chain.  If
    // set while first responder, will not take effect until reloadInputViews is called.
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
    
    // defaults to NO. if YES, the selection UI is hidden, and inserting text will replace the contents of the field. changing the selection will automatically set this to NO.
    @available(iOS 6.0, *)
    @discardableResult
    public func clearsOnInsertion(_ value:Bool) -> LinkCreator {
        base.clearsOnInsertion = value
        return self
    }
    
    // Inset the text container's layout area within the text view's content area
    @available(iOS 7.0, *)
    @discardableResult
    public func textContainerInset(_ value:UIEdgeInsets) -> LinkCreator {
        base.textContainerInset = value
        return self
    }
    
    // Style for links
    @available(iOS 7.0, *)
    @discardableResult
    public func linkTextAttributes(_ value:[String : AnyObject]!) -> LinkCreator {
        base.linkTextAttributes = value
        return self
    }
}
