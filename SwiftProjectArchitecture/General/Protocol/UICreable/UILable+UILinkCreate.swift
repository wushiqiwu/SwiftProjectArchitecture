//
//  UILable+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension LinkCreator where Base : UILabel{
    
    @discardableResult
    public func text(_ value: String?) -> LinkCreator {
        base.text = value
        return self
    }
    
    @discardableResult
    public func font(_ value: UIFont) -> LinkCreator {
        base.font = value
        return self
    }
    
    
    @discardableResult
    public func textColor(_ value: UIColor) -> LinkCreator {
        base.textColor = value
        return self
    }
    
    @discardableResult
    public func shadowColor(_ value: UIColor?) -> LinkCreator {
        base.shadowColor = value
        return self
    }
    
    @discardableResult
    public func shadowOffset(_ value: CGSize) -> LinkCreator {
        base.shadowOffset = value
        return self
    }
    
    @discardableResult
    public func textAlignment(_ value: NSTextAlignment) -> LinkCreator {
        base.textAlignment = value
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ value: NSLineBreakMode) -> LinkCreator {
        base.lineBreakMode = value
        return self
    }
    
    @discardableResult
    @available(iOS 6.0, *)
    public func attributedText(_ value: NSAttributedString?) -> LinkCreator {
        base.attributedText = value
        return self
    }
    
    @discardableResult
    public func highlightedTextColor(_ value: UIColor?) -> LinkCreator {
        base.highlightedTextColor = value
        return self
    }
    
    @discardableResult
    public func highlighted(_ value: Bool) -> LinkCreator {
        base.isHighlighted = value
        return self
    }
    
    @discardableResult
    public func enabled(_ value: Bool) -> LinkCreator {
        base.isEnabled = value
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ value: Int) -> LinkCreator {
        base.numberOfLines = value
        return self
    }
}
