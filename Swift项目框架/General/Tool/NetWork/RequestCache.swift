//
//  RequestCache.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/8.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation

struct RequestCache {
    
    func getCacheData(with tool:Requester)->Any?{
        
        guard let filePath = getPath(with: tool) , FileManager.default.fileExists(atPath: filePath) else { return  nil }
        
        do{
            
            //取出加密的Data
            let cacheData = try Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
            
            //解密
            guard let password = AESTool.decode(cacheData) else { return nil }
            
            //转Json
            return try JSONSerialization.jsonObject(with: password, options: .allowFragments)
            
        }catch let e{
            printLog(e)
            return nil
        }
    }
    
    func setCacheData(with tool:Requester , json : Any){
        
        guard let filePath = getPath(with: tool) else { return }
        
        do{
            //Json转Data
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            //Data加密
            if let ciphertext = AESTool.endcode(jsonData){
                try ciphertext.write(to: URL.init(fileURLWithPath: filePath), options: .atomic)
            }
            
        }catch let e{
            printLog(e)
        }
    }
    
    fileprivate func getPath(with tool:Requester)->String?{
        guard var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil }
        path.append(contentsOf: "/"+tool.path)
        return path
    }
}

