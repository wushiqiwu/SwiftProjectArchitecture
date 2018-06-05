//
//  Api.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/4.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit

enum ApiError : Error{
    case requestError(msg : String)
}

protocol ApiRequestProtocol {
    
}


struct Api : ApiRequestProtocol{
    fileprivate init(){}
}
