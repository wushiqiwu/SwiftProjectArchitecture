//
//  ThreadTool.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/11/24.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation

struct ThreadTool {
    fileprivate init(){}
}


//MARK: - 延时操作
extension ThreadTool{
    static func delayToMain(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    static func delayToGlobal(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.global().asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
