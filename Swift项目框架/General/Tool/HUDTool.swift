//
//  HUDTool.swift
//  汇享天下Swift
//
//  Created by wushiqi on 2017/8/31.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import MBProgressHUD

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
    
    class final func showMessage(msg : String){
        k_showMessage(msg: msg, delay: constDelay,handel: nil)
    }
    
    class final func showMessage(msg : String , delay : Double) {
        k_showMessage(msg: msg, delay: delay,handel: nil)
    }
    
    class final func showMessage(msg : String,handel : completeHandel?){
        k_showMessage(msg: msg, delay: constDelay,handel:handel)
    }
    
    class final func showMessage(msg : String, delay : Double , handel : completeHandel?){
        k_showMessage(msg: msg, delay: constDelay,handel:handel)
    }
    fileprivate class final func k_showMessage(msg : String , delay : Double,handel : completeHandel?) {
        
        (APP.keyWindow.viewWithTag(ShowStyle.ShowText.rawValue) as? MBProgressHUD)?.hide(animated: false)
        
        let lastHud = APP.keyWindow.viewWithTag(ShowStyle.ShowText.rawValue) as? MBProgressHUD
        var newHud  : MBProgressHUD! = nil
        if( lastHud == nil ){
            
            newHud = MBProgressHUD.init(view: APP.keyWindow)
            APP.keyWindow.addSubview(newHud)
            newHud.tag = ShowStyle.ShowText.rawValue
            newHud.removeFromSuperViewOnHide = true
            newHud.mode = .text
            newHud.label.font = UIFont.size14
            newHud.bezelView.color = UIColor.black
            newHud.label.textColor = UIColor.white;
            
        }else{
            newHud = lastHud
            newHud.completionBlock?()
        }
        
        newHud.label.text = msg
        newHud.completionBlock = handel
        newHud.show(animated: true)
        newHud.hide(animated: true, afterDelay: delay)
    }
}

//显示HUD
extension HUDTool{
    
    class final func showHUD(){

        (APP.keyWindow.viewWithTag(ShowStyle.ShowText.rawValue) as? MBProgressHUD)?.hide(animated: false)
        
        let lastHud = APP.keyWindow.viewWithTag(ShowStyle.ShowHUD.rawValue) as? MBProgressHUD
        var newHud  : MBProgressHUD! = nil
        if( lastHud == nil ){
            
            newHud = MBProgressHUD.init(view: APP.keyWindow)
            APP.keyWindow.addSubview(newHud)
            newHud.tag = ShowStyle.ShowHUD.rawValue
            newHud.removeFromSuperViewOnHide = true
            newHud.mode = .indeterminate
            newHud.graceTime = 0.5
            newHud.bezelView.color = UIColor.black
            newHud.contentColor    = UIColor.white
        }else{
            newHud = lastHud
        }
        
        newHud.show(animated: true)
    }
    
    class final func  hiddenHUD(){
       (APP.keyWindow.viewWithTag(ShowStyle.ShowHUD.rawValue) as? MBProgressHUD)?.hide(animated: true)
    }
}
