//
//  String+Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/11/21.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

//MARK: - 计算
extension String{
    
    func contentRect( font : UIFont, maxWidth : Double, maxHeight : Double) -> CGRect{
        
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        let nsStr = self as NSString
        var rect = nsStr.boundingRect(with: CGSize.init(width: maxWidth, height: maxHeight),
                                      options: option,
                                      attributes: attributes,
                                      context: nil)
        rect.size.width  += 1
        rect.size.height += 1
        return rect
    }
}


//MARK: - 显示
extension String{
    
    //电话号码中间4位****显示
    var secrectPhoneNumber : String{
        
        guard self.count == 11 else { return self  }
        
        var temp = self
        let startIndex = temp.index(temp.startIndex, offsetBy: 3)
        let endIndex   = temp.index(startIndex, offsetBy: 4)
        
        let replacedRange = startIndex...endIndex
        temp.replaceSubrange(replacedRange, with: "****")
        return temp
    }
    
    //银行卡号中间8位显示
    var secrectBankNo : String{
        
        guard self.count > 12 else { return self  }
        
        var temp = self
        let startIndex = temp.index(temp.startIndex, offsetBy: 4)
        let endIndex   = temp.index(startIndex, offsetBy: 8)
        
        let replacedRange = startIndex...endIndex
        temp.replaceSubrange(replacedRange, with: " **** **** ")
        return temp
    }
}

//MARK: - 正则
extension String{
    
    //有效的手机号码
    var isMobileNumber : Bool{
        let str       = "^1(3|4|5|7|8)\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //有效的固定电话
    var isValidTelephone : Bool{
        let str       = "^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$|^400[0-9]{7}$|^800[0-9]{7}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //有效的真实姓名
    var isValidRealName : Bool{
        let str       = "^[\u{4e00}-\u{9fa5}]{2,8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //是否只有中文
    var isOnlyChinese : Bool{
        let str       = "^[\u{4e00}-\u{9fa5}]{0,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //有效的验证码(根据自家的验证码位数进行修改)
    var isValidVerifyCode : Bool{
        let str       = "^[0-9]{6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //有效的银行卡号
    var isValidBankCardNumber : Bool{
        let str       = "^(\\d{16}|\\d{19})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //有效的邮箱
    var isValidEmail : Bool{
        let str       = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //有效的字母数字密码
    var isValidAlphaNumberPassword : Bool{
        let str       = "^(?!\\d+$|[a-zA-Z]+$)\\w{6,12}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //检测有效身份证 15位
    var isValidIdentifyFifteen : Bool{
        let str       = "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //检测有效身份证 18位
    var isValidIdentifyEighteen : Bool{
        let str       = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", str)
        return predicate.evaluate(with: self)
    }
    
    //检验密码 6-16位字符+数字混合
    var isValidPassword : Bool{
        
        //2-10位汉字
        let chineseTest = "^[\u{4e00}-\u{9fa5}]{2,10}$"
        let chinesePredicate = NSPredicate(format: "SELF MATCHES %@", chineseTest)
        
        //3-20个字符
        let charTest = "^[a-zA-Z]{3,20}$"
        let charPredicate = NSPredicate(format: "SELF MATCHES %@", charTest)
        
        //字符,特殊符号,数字和汉字混合,以及下划线 _ , 3-20位内 (数字和特殊符号不是必须的)
        let blendedTest = "^(?![a-zA-Z]+$)(?![\u{4e00}-\u{9fa5}]+$)[0-9a-zA-Z\u{4e00}-\u{9fa5}_]{3,20}$"
        let blendedPredicate = NSPredicate(format: "SELF MATCHES %@", blendedTest)
        
        return chinesePredicate.evaluate(with: self) && charPredicate.evaluate(with: self) && blendedPredicate.evaluate(with: self)
    }
}
