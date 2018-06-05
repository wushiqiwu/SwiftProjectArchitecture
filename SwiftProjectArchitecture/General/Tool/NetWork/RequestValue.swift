//
//  RequestValue.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/13.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

class ResponseObject{
    
    var errCode  : Int    = 0
    var message  : String = ""
    var data     : Any?
    var mapObj   : Mappable?
    
}

enum RequestResult{
    
    case success( ResponseObject )
    case failure( ErrorType )
    
    enum ErrorType{
        case error(String)
        case relist
        func message()->String{
            switch self {
            case .error(let msg):
                return msg
            case .relist:
                return "需要重新登录"
            }
        }
    }
}
