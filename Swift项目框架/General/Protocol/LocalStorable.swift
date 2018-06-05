//
//  LocalStoreTool.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/10/9.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation

fileprivate var cacheDictionary = Dictionary<String,LocalStorable>()

///序列化本地化存储数据的协议,Any或者AnyObjcet实现该协议即可使用协议内部方法
protocol LocalStorable : Codable{
}

//MARK:- Public
extension LocalStorable{
    
    ///缓存该对象,返回值标识是否成功
    @discardableResult
    func caching() -> Bool{
        
        guard let filePath = Self.filePath else { return false }
        
        do{
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            
            //AES加密
            if let ciphertext = AESTool.endcode(data){
                try ciphertext.write(to: URL.init(fileURLWithPath: filePath), options: .atomic)
                cacheDictionary.updateValue(self, forKey: Self.key)
                printLog( Self.key + " : " + filePath)
                return true
            }else{
                return false
            }
            
        }catch let e{
            printLog(e)
            return false
        }
    }
    
    
    ///取出缓存的对象,可能没有
    static  var cachedData : Self?{
        if let cacheData = cacheDictionary[key], let temp = cacheData as? Self{ return temp }
        if let temp = getCachedData() as? Self{ return temp  }
        return nil
    }
    
    ///删除缓存的对象
    @discardableResult
    static func deleteCacheData() -> Bool{
        
        if cacheDictionary.keys.contains(Self.key){
            cacheDictionary.removeValue(forKey: Self.key)
        }
        
        guard let filePath = Self.filePath , FileManager.default.fileExists(atPath: filePath) else{ return false }
        do{
            try FileManager.default.removeItem(atPath: filePath)
            return true
        }catch let e{
            print(e)
            return false
        }
    }
}


//MARK:- Private
extension LocalStorable{
    
    static fileprivate var key : String {
        var name = "\(type(of: self))"
        if let index = name.index(of: ".") {
            name = String(name[..<index])
        }
        return "LocalStorable_" + name
    }
    
    static fileprivate var filePath : String? {
        guard var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil }
        path.append(contentsOf: "/"+Self.key)
        return path
    }
    
    
    fileprivate static func getCachedData() -> LocalStorable?{
        
        guard let filePath = Self.filePath else { return nil }
        if FileManager.default.fileExists(atPath: filePath) == false { return nil }
        
        do{
            let ciphertext = try Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
            
            //解密
            if let password = AESTool.decode(ciphertext){
                let decoder = JSONDecoder()
                let obj =  try decoder.decode(self, from: password)
                return obj
            }else{
                return nil
            }
            
        }catch let e{
            print(e)
            return nil
        }
    }
}

extension Array : LocalStorable where Element : LocalStorable {}
