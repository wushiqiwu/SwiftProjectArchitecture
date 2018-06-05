//
//  ServersAESTool.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/11/29.
//  Copyright © 2017年 wushiqi. All rights reserved.
//  适应Java后台的AES加解密

import Foundation

struct ServersAESTool {
    
    static func endcode(json:String)->String{
        return EncryptDecrypt.shareInstance().stringEncrypt(json)
    }
    
    static func decode( ciphertextString : String)->String?{
        guard let data = ciphertextString.data(using: .utf8) else {  return nil }
        return self.decode(ciphertextData: data)
    }
    
    static func decode(ciphertextData :Data)->String{
      return  EncryptDecrypt.shareInstance().dataDecrypt(ciphertextData)
    }
    
    fileprivate init(){}
}
