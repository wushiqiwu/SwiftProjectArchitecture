//
//  CacheService.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/30.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import Foundation
import Cache

//MARK: - 服务
struct CacheService {
    
    fileprivate init(){}
    
    //移除默认缓存目录里所有缓存文件
    @discardableResult
    static func removeAllCache() -> Bool{
        do {
            let storage = try Storage(diskConfig: DiskConfig(name: APP.cacheDirectoryName), memoryConfig: MemoryConfig())
            try storage.removeAll()
            return true
        } catch{
            debugPrint("删除所有缓存文件失败:\n\(error)")
            return false
        }
    }
    
    //移除默认缓存目录里所有过期缓存文件
    @discardableResult
    static func removeExpiredObjects() -> Bool{
        do {
            let storage = try Storage(diskConfig: DiskConfig(name: APP.cacheDirectoryName), memoryConfig: MemoryConfig())
            try storage.removeExpiredObjects()
            return true
        } catch{
            debugPrint("删除所有过期缓存文件失败:\n\(error)")
            return false
        }
    }
}



//MARK: - 实现者
extension UserModel : Cacheable{
    
    static func cacheKey() -> String{
        return "userModel"
    }
}


