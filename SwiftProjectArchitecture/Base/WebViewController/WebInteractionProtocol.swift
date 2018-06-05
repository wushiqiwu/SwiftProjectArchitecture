//
//  WebInteractionProtocol.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/9/28.
//  Copyright © 2017年 wushiqi. All rights reserved.
//  通过自定义URL交互的协议

import UIKit

protocol WebInteractionProtocol {
    
    func nextNode() -> WebInteractionProtocol
    func handleInteraction(request : URLRequest) -> Bool
    
    func pushToViewController(vc : UIViewController)
}
