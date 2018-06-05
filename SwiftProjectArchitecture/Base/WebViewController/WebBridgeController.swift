//
//  WebBridgeController.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/9/28.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import WebKit

extension BaseWebVC{
    
    func configWebBridgeController()  {
        
        WKWebViewJavascriptBridge.enableLogging()
        bridgeController = WKWebViewJavascriptBridge.init(for: webView)
        bridgeController?.setWebViewDelegate(self)
        
        setBaseInteraction()
    }
    
    func setBaseInteraction(){
        
        bridgeController?.registerHandler("JSInto", handler: { (_, _) in
            print("JS开始注入")
        })
    }
}


