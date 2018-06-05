//
//  UIButton+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension LinkCreator where Base : UIButton{
    
    // MARK: Button targer
    @discardableResult
    public func target(_ target: AnyObject?, action: Selector, forControlEvents: UIControlEvents) -> LinkCreator {
        base.addTarget(target, action: action, for: forControlEvents)
        return self
    }
    
    // MARK: button title
    @discardableResult
    public func title(_ value: String, state: UIControlState) -> LinkCreator {
        base.setTitle(value, for: state)
        return self
    }
    
    @discardableResult
    public func nomalStateTitle(_ value: String) -> LinkCreator {
        base.setTitle(value, for: .normal)
        return self
    }
    
    @discardableResult
    public func highlightedStateTitle(_ value: String) -> LinkCreator {
        base.setTitle(value, for: .highlighted)
        return self
    }
    
    @discardableResult
    public func selectedStateTitle(_ value: String) -> LinkCreator {
        base.setTitle(value, for: .selected)
        return self
    }
    
    // MARK: button title color
    @discardableResult
    public func titleColor(_ value: UIColor, state: UIControlState) -> LinkCreator {
        base.setTitleColor(value, for: state)
        return self
    }
    
    @discardableResult
    public func nomalStateTitleColor(_ value: UIColor) -> LinkCreator {
        base.setTitleColor(value, for: .normal)
        return self
    }
    
    @discardableResult
    public func highlightedStateTitleColor(_ value: UIColor) -> LinkCreator {
        base.setTitleColor(value, for: .highlighted)
        return self
    }
    
    @discardableResult
    public func selectedStateTitleColor(_ value: UIColor) -> LinkCreator {
        base.setTitleColor(value, for: .selected)
        return self
    }
    
    // MARK: button title shadow color
    @discardableResult
    public func titleShadowColor(_ value: UIColor, state: UIControlState) -> LinkCreator {
        base.setTitleShadowColor(value, for: state)
        return self
    }
    
    @discardableResult
    public func nomalStateTitleShadowColor(_ value: UIColor) -> LinkCreator {
        base.setTitleShadowColor(value, for: .normal)
        return self
    }
    
    @discardableResult
    public func highlightedStateTitleShadowColor(_ value: UIColor) -> LinkCreator {
        base.setTitleShadowColor(value, for: .highlighted)
        return self
    }
    
    @discardableResult
    public func selectedStateTitleShadowColor(_ value: UIColor) -> LinkCreator {
        base.setTitleShadowColor(value, for: .selected)
        return self
    }
    
    
    // MARK: button image
    @discardableResult
    public func image(_ value: UIImage?, state: UIControlState) -> LinkCreator {
        base.setImage(value, for: state)
        return self
    }
    
    @discardableResult
    public func nomalStateImage(_ value: UIImage?) -> LinkCreator {
        base.setImage(value, for: .normal)
        return self
    }
    
    @discardableResult
    public func highlightedStateImage(_ value: UIImage?) -> LinkCreator {
        base.setImage(value, for: .highlighted)
        return self
    }
    
    @discardableResult
    public func selectedStateImage(_ value: UIImage?) -> LinkCreator {
        base.setImage(value, for: .selected)
        return self
    }
    
    // MARK: button background image
    @discardableResult
    public func backgroundImage(_ image: UIImage, state: UIControlState) -> LinkCreator {
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func nomalStateBackgroundImage(_ value: UIImage) -> LinkCreator {
        base.setBackgroundImage(value, for: .normal)
        return self
    }
    
    @discardableResult
    public func highlightedStateBackgroundImage(_ value: UIImage) -> LinkCreator {
        base.setBackgroundImage(value, for: .highlighted)
        return self
    }
    
    @discardableResult
    public func selectedStateBackgroundImage(_ value: UIImage) -> LinkCreator {
        base.setBackgroundImage(value, for: .selected)
        return self
    }
    
    // MARK: button Attributed Title
    @discardableResult
    public func attributedTitle(_ attr: NSAttributedString, state: UIControlState) -> LinkCreator {
        base.setAttributedTitle(attr, for: state)
        return self
    }
    
    @discardableResult
    public func normalStateAttributedTitle(_ attr: NSAttributedString) -> LinkCreator {
        base.setAttributedTitle(attr, for: .normal)
        return self
    }
    
    @discardableResult
    public func selectedStateAttributedTitle(_ attr: NSAttributedString) -> LinkCreator {
        base.setAttributedTitle(attr, for: .selected)
        return self
    }
    
    @discardableResult
    public func highLightedStateAttributedTitle(_ attr: NSAttributedString) -> LinkCreator {
        base.setAttributedTitle(attr, for: .highlighted)
        return self
    }
    
    @discardableResult
    public func font(_ value : UIFont)->LinkCreator{
        base.titleLabel?.font = value
        return self
    }
    
    @discardableResult
    public func imageEdge(_ value : UIEdgeInsets)->LinkCreator{
        base.imageEdgeInsets = value
        return self
    }
    
    @discardableResult
    public func titleEdge(_ value : UIEdgeInsets)->LinkCreator{
        base.titleEdgeInsets = value
        return self
    }
}

extension LinkCreator where Base : UIButton{
    
    public typealias CustomButtonAction = (UIButton) -> ()
    
    //快速添加点击事件
    @discardableResult
    public func addAction(_ action:@escaping CustomButtonAction)->LinkCreator{
        base.addAction(action)
        return self
    }
}
