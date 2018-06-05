//
//  AES.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/11/22.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation
import CryptoSwift


struct AESTool {
    
 fileprivate  static let AESKey : String = "FAC9A334561B47B1"
    
    //AES-ECB128加密
    static func endcode(_ data:Data)->Data?{
        
        var encrypted: [UInt8] = []
        let key = [UInt8](AESKey.data(using: .utf8)!)
        
        do {
            let aes = try AES.init(key: key, blockMode: ECB(), padding: .pkcs7)
            encrypted = try aes.encrypt([UInt8](data))
            let encoded = Data(encrypted)
            return  encoded.base64EncodedData() //加密完后,再转Base64
        } catch {
            return nil
        }
    }
    
    
    //AES-ECB128解密
    static func decode(_ ciphertext:Data)->Data?{
        
        //decode base64
       let data = Data.init(base64Encoded: ciphertext, options: Data.Base64DecodingOptions.init(rawValue: 0))

        let encrypted = [UInt8](data!)

        var decrypted: [UInt8] = []
        let key = [UInt8](AESKey.data(using: .utf8)!)

        do {
            let aes = try AES.init(key: key, blockMode: ECB(), padding: .pkcs7)
            decrypted = try aes.decrypt(encrypted)
            return  Data(decrypted)
        } catch {
            return nil
        }

    }

    fileprivate init(){}
}
