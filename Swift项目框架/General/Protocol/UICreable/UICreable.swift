//
//  UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import RxSwift


//Link创建者
public struct LinkCreator<Base : UIView> {
    let base : Base
    init(_ base : Base){
        self.base = base
    }
}

//兼容切换协议
public protocol LinkCreateCompatible{}
extension UIView : LinkCreateCompatible{}
extension LinkCreateCompatible where Self : UIView{
    static var link : LinkCreator<Self> {
        return LinkCreator(self.init())
    }
    var link: LinkCreator<Self> {
        return LinkCreator(self)
    }
}



