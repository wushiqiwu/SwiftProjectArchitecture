//
//  URLConst.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

/*
 #define TestBaseURL                 @"http://agentapi.test.oa.com"
 #define DeveloperBaseURL            @"http://agentapi.dev.oa.com"
 #define PreformBaseURL              @"http://phapi.zhiguohulian.com"
 #define LittleSnailReleaseBaseURL   @"https://api.xiaowonet.com"        //小蜗正式
 #define KathleenReleaseBaseURL      @"https://api.zhiguohulian.com"     //小智正式
 */

//环境
struct Environment{
    
    enum ApiEnvironment : String{
        
        case test       = "http://agentapi.test.oa.com"
        case developer  = "http://agentapi.dev.oa.com"
        case preform    = "http://phapi.zhiguohulian.com"
        
        #if ZGLittleSnail
        case release    = "https://api.xiaowonet.com"
        #elseif ZGKathleen
        case release    = "https://api.zhiguohulian.com"
        #else
        case release    = "https://api.zhiguohulian.com"
        #endif
    }
    
    var currentEnvironment : ApiEnvironment = .developer //设置默认环境

    static let single = Environment()
    
    var appBaseURL : String{
        #if DEBUG
        return currentEnvironment.rawValue
        #else
        return RequestEnvironment.release.rawValue
        #endif
        
    }
    
    fileprivate init(){}
}


extension APP{
    
    //用户协议
    static var userAgreementURL : String{
        
        var url = ""
        #if ZGLittleSnail
        url = "/agreement.html"
        #elseif ZGKathleen
        url = "/agreement_xiaozhi.html"
        #else
        url = ""
        #endif
        return Environment.single.appBaseURL + url
    }
}


