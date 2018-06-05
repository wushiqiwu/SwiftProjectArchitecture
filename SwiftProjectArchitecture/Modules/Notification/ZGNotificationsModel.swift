//
//  ZGNotificationsModel.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/28.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import Foundation

struct ZGNotificationsModel : Mappable{
    
    var uid : String = ""
    var notice_title : String = ""
    var notice_source : String = ""
    var created_at : String = ""
    var notice_body : String = ""
    var project_name : String = ""
    var status : Int = 0

}
