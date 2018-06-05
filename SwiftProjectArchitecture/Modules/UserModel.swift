//
//  UserModel.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/4.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import Foundation

struct UserModel : Mappable , Codable{
    
    var token : String  = ""
    var user : UserInfo = .init()
    var mqtt : MqttInfo = .init()
    var sip  : SipInfo  = .init()
    
    struct UserInfo : Mappable,LocalStorable{
        var created_at : String = ""
        var deleted_at : String = ""
        var uid : String = ""
        var user_nickname : String = ""
        var user_phone : String = ""
        var user_realname : String = ""
        var user_verified : String = ""
    }
    struct MqttInfo : Mappable,LocalStorable{
        var ip : String = ""
        var port : String = ""
        var username : String = ""
        var password : String = ""
    }
    struct SipInfo : Mappable,LocalStorable{
        var ip : String = ""
        var port : String = ""
        var username : String = ""
        var password : String = ""
    }
}

