//
//  HUDTool.swift
//  汇享天下Swift
//
//  Created by wushiqi on 2017/8/31.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

enum ShowStyle : Int {
    
    case ShowText = 2017831
    case ShowHUD
}

public final class HUDTool {
    
    typealias completeHandel = ()->Void
    
    fileprivate static let constDelay = 1.5;
    fileprivate init(){}
}

//显示消息
extension HUDTool{
    
    class final func showSuccess(_ success : String){
        MBProgressHUD.showSuccess(success)
    }
    
    class final func showError(_ error : String){
        MBProgressHUD.showError(error)
    }
    
}

//显示HUD
extension HUDTool{
    
    class final func showHUD(){
        MBProgressHUD.showMessage(nil, graceTime: Float(constDelay))
    }
    
    class final func showHUD(_ text : String){
        MBProgressHUD.showMessage(text,graceTime: Float(constDelay))
    }
    
    class final func  hiddenHUD(){
        MBProgressHUD.hide()
    }
}
