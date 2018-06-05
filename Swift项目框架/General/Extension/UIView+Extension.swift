//
//  UIView_Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/11/21.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation

//MARK:- 快速点击事件
fileprivate var CustomTapActionKey = "CustomTapAction"
extension UIView{
    public typealias CustomTapAction = (UITapGestureRecognizer) -> ()
    @objc fileprivate var tapAction : CustomTapAction?{
        set{  objc_setAssociatedObject(self, &CustomTapActionKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get{  return objc_getAssociatedObject(self, &CustomTapActionKey ) as? CustomTapAction }
    }
    
    @discardableResult
    public func addTapGesture(action: @escaping CustomTapAction)->Self{
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(UIView.customTapAction(tap:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
        tapAction = action
        return self
    }
    
    @objc fileprivate func customTapAction(tap : UITapGestureRecognizer){
        if tap.state == .ended , let temp = tapAction{
            temp(tap)
        }
    }
}




//MARK: - 圆角
extension UIView{
    func borderRadius(radius : CGFloat , width : CGFloat? , color : UIColor?)->Self{
        defer {  layer.masksToBounds = true }
        layer.cornerRadius = radius
        if let temp = width{ layer.borderWidth = temp   }
        if let temp = color{  layer.borderColor = temp.cgColor }
        return self 
    }
}
