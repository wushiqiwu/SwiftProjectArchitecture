//
//  RequestManager.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/8.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

///管理使用中的Tool
class RequestManager{
    
    static let share = RequestManager()
    let cache = RequestCache()
    
    private var requests: [String: Requester] = [:]
    private let lock = NSLock()
    
    fileprivate init(){}
    subscript(tool: Requester) -> Requester? {
        get {
            lock.lock() ; defer { lock.unlock() }
            return requests[tool.identifier]
        }
        set {
            lock.lock() ; defer { lock.unlock() }
            requests[tool.identifier] = newValue
        }
    }
}
