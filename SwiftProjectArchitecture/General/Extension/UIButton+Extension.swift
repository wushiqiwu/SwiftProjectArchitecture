//
//  UIButton_SSExtension.swift
//  点点汇
//
//  Created by wushiqi on 2017/9/1.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

//MARK:- 创建
extension UIButton{
    
    public convenience init(normalStateTitle:String?,
                            titleFont:UIFont?,
                            titleColor:UIColor? ,
                            backgroundColor:UIColor?,
                            clickThingTarget:[AnyObject]?,
                            action:Selector?) {
        
        self.init(type: .custom)
        setTitle(normalStateTitle, for: .normal)
        titleLabel?.font = titleFont
        setTitleColor(titleColor, for: .normal)
        
        if let temp = backgroundColor{ self.backgroundColor = temp }
        if let targetTemp = clickThingTarget, let actionTemp = action {
            self.addTarget(targetTemp, action: actionTemp, for: .touchUpInside)
        }
    }
}


//MARK:- 快速按钮事件
fileprivate var CustomButtonActionKey = "CustomButtonAction"

extension UIButton{
    
    public typealias CustomButtonAction = (UIButton) -> ()
    
    @objc fileprivate var buttonAction : CustomButtonAction{
        
        set{
            objc_setAssociatedObject(self, &CustomButtonActionKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get{
            return objc_getAssociatedObject(self, &CustomButtonActionKey ) as! CustomButtonAction
        }
    }
    
    //快速添加点击事件
    @discardableResult
    public func addAction(_ action:@escaping CustomButtonAction)->Self{
        buttonAction = action
        self.addTarget(self, action: #selector(UIButton.customButtonAction(button:)), for: .touchUpInside)
        return self
    }
    
    @objc fileprivate func customButtonAction(button : UIButton){
        buttonAction(button)
    }
}

