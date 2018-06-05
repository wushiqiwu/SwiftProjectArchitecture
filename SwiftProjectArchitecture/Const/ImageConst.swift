//
//  ImageConst.swift
//  ZGLittleSnail
//
//  Created by 吴施岐 on 2018/4/10.
//  Copyright © 2018年 chenxingbin. All rights reserved.
//

import UIKit

extension APP{
    
    //登录页背景图片
    static var logingBackGroundImage : String{
        #if ZGLittleSnail
        return "LogingBG_ZGLittleSnail"
        #elseif ZGKathleen
        return "LogingBG_ZGKathleen"
        #else
        return "LogingBG_ZGKathleen"
        #endif
    }
}
