//
//  AlertTool.swift
//  汇享天下Swift
//
//  Created by wushiqi on 2017/8/31.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

public class AlertHandel {
    
    typealias CompletHandel = ()->Void
    
    static let cancelHandel = AlertHandel.handel(withTitle: "取消", completeBolck: nil)
    static let confimHandel = AlertHandel.handel(withTitle: "确定", completeBolck: nil)
    
    var block : CompletHandel?
    var title : String
    
    class func handel(withTitle title : String , completeBolck : CompletHandel?) -> AlertHandel{
        
        let handel = AlertHandel(title: title)
        handel.block = completeBolck
        return handel
    }
    
    fileprivate init(title : String ){
        self.title = title;
    }
    
}


public class AlertTool: NSObject {
    
    fileprivate override init() {}
    
    //Alert
    class func showAlert(alertTitle title : String? = "" ,
                         message : String,
                         cancel : AlertHandel? = AlertHandel.cancelHandel ,
                         confim : AlertHandel? = AlertHandel.confimHandel ,
                         other  : [AlertHandel]?) {
        
        k_show(controllerStyle: .alert,
               alertTitle: title,
               message: message,
               cancel: cancel,
               confim: confim,
               other: other)
        
    }
    
    
    //Sheet
    class func showSheet(alertTitle title : String? = "",
                         message : String,
                         cancel : AlertHandel? = AlertHandel.cancelHandel ,
                         other  : [AlertHandel]?) {
        
        k_show(controllerStyle: .actionSheet,
               alertTitle: title,
               message: message,
               cancel: cancel,
               confim: nil,
               other: other)
    }

    
    fileprivate class func k_show(controllerStyle : UIAlertControllerStyle,
                                  alertTitle title : String? = "" ,
                                  message : String,
                                  cancel : AlertHandel? = AlertHandel.cancelHandel ,
                                  confim : AlertHandel? = AlertHandel.confimHandel ,
                                  other  : [AlertHandel]?) {
        
        let controller =  UIAlertController.init(title: title, message: message, preferredStyle: controllerStyle)
        
        if( cancel != nil ){
            let action = UIAlertAction.init(title: cancel?.title, style: .cancel, handler: { (action) in
                cancel?.block?()
            })
            controller.addAction(action)
        }
        
        if( confim != nil ){
            let action = UIAlertAction.init(title: confim?.title, style: .`default`, handler: { (action) in
                confim?.block?()
            })
            controller.addAction(action)
        }
        
        if let array = other{
            for sub in array{
                let action = UIAlertAction.init(title: sub.title, style: .`default`, handler: { (action) in
                    sub.block?()
                })
                controller.addAction(action)
            }
        }
        UIViewController.topViewController?.present(controller, animated: true, completion: nil)
    }
}

