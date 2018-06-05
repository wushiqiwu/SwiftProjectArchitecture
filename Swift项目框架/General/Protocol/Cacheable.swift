//
//  Cacheable.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/30.
//  Copyright © 2018年 wushiqi. All rights reserved.
//  对象缓存协议

import Foundation
import Cache 


protocol Cacheable : Codable{
    
    //缓存对象的Json
    @discardableResult
    static func cacheJson(_ json : Any?) -> Bool
    
    //对象实例缓存自己
    @discardableResult
    func cacheSelf() -> Bool
    
    //获取缓存对象
    static func getCacheData() -> Self?
    
    //移除缓存
    @discardableResult
    static func removeCacheData() -> Bool
    
    //缓存的Key
    static func cacheKey() -> String
}

//MARK: - 缓存目录
extension Cacheable{
    
    static func directoryName() -> String{
        return APP.cacheDirectoryName
    }
}

//MARK: - 默认实现
extension Cacheable{
    
    @discardableResult
    func cacheSelf() -> Bool{
        do {
            let storage = try Storage(diskConfig: DiskConfig(name: Self.directoryName()), memoryConfig: MemoryConfig())
            try storage.setObject(self, forKey: Self.cacheKey())
            return true
        } catch{
            debugPrint("缓存数据失败:\n\(error)")
            return false
        }
    }
    
    @discardableResult
    static func cacheJson(_ json : Any?) -> Bool{
        
        if json == nil {
            debugPrint("缓存数据失败: Json为空")
            return false
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json!, options: .prettyPrinted)
            let model = try JSONDecoder().decode(self, from: data) //Json转Model
            let storage = try Storage(diskConfig: DiskConfig(name: Self.directoryName()), memoryConfig: MemoryConfig())
            try storage.setObject(model, forKey: cacheKey())
            return true
        } catch{
            debugPrint("缓存数据失败:\n\(error)")
            return false
        }
    }
    
    
    static func getCacheData()->Self?{
        do {
            let storage = try Storage(diskConfig: DiskConfig(name: Self.directoryName()), memoryConfig: MemoryConfig())
            let entry = try? storage.entry(ofType: self, forKey: cacheKey())
            return entry?.object
        } catch{
            debugPrint("获取除缓存数据失败:\n\(error)")
            return nil
        }
    }
    
    @discardableResult
    static func removeCacheData() -> Bool {
        do {
            let storage = try Storage(diskConfig: DiskConfig(name: Self.directoryName()), memoryConfig: MemoryConfig())
            try storage.removeObject(forKey: cacheKey())
            return true
        } catch{
            debugPrint("删除:\n\(error)")
            return false
        }
    }
}
