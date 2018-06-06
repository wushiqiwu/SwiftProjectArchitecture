//
//  UIView+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import SnapKit

extension LinkCreator where Base  : UIView{
    
    @discardableResult
    public func frame( _ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat)->LinkCreator{
        base.frame = CGRect.init(x: x, y: y, width: w, height: h)
        return self
    }
    
    @discardableResult
    public func userInteractionEnabled(_ value: Bool) -> LinkCreator {
        base.isUserInteractionEnabled = value
        return self
    }
    
    @discardableResult
    public func bgColor(_ value: UIColor) -> LinkCreator {
        base.backgroundColor = value
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ value: CGFloat) -> LinkCreator {
        base.layer.cornerRadius = value
        base.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    public func cornerRadiusHalf() -> LinkCreator {
        base.layer.cornerRadius = base.frame.height / 2.0
        return self
    }
    
    @discardableResult
    public func border(_ width: CGFloat, _ color: UIColor) -> LinkCreator {
        base.layer.borderWidth = width
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult
    public func hidden(_ value: Bool) -> LinkCreator {
        base.isHidden = value
        return self
    }
    
    @discardableResult
    public func tag(_ value: NSInteger) -> LinkCreator {
        base.tag = value
        return self
    }
    
    @discardableResult
    public func addToView(_ value: UIView) -> LinkCreator {
        value.addSubview(base)
        return self
    }
    
    @discardableResult
    public func addView(_ subView: UIView) -> LinkCreator {
        base.addSubview(subView)
        return self
    }
    
    @discardableResult
    public func alpha(_ value: CGFloat) -> LinkCreator {
        base.alpha = value
        return self
    }
    
    @discardableResult
    public func layout(_ closure: (_ make: ConstraintMaker) -> Void)->LinkCreator{
        base.snp.makeConstraints(closure)
        return self
    }
}

//快速添加手势
extension LinkCreator where Base : UIView{
    
    public typealias CustomTapAction = (UITapGestureRecognizer) -> ()
    
    @discardableResult
    public func addTapGesture(action: @escaping CustomTapAction)->LinkCreator{
        base.addTapGesture(action: action)
        return self
    }
}
