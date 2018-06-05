//
//  AddressModel.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/9/19.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation

struct AddressModel : Mappable,LocalStorable{
    
    var userId : Int?
    var address : String?
    var detailedAddress : String?
    var addressId : Int?
    var consigneePhone : String?
    var zipcode : String?
    var defaultSelected : Bool?
    var consigneeName : String?

}
