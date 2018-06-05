//
//  Mappable.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/11/22.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation

///JSON解析映射为Model
protocol Mappable  : Decodable {
    static func mapping(_ data : Any?)->Self?
}
extension Array : Mappable where Element : Mappable {}
extension Mappable{

    static func mapping(_ data : Any?)->Self?{
        guard let json = data else {  return nil  }
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return try JSONDecoder().decode(self, from: data)
        }catch let error{
            print("MappableError:\n \(error) ")
            return nil
        }
    }
}


//protocol Mappable : HandyJSON {
//    static func mapping(_ data : Any?)->Self?
//}
//extension Mappable{
//    static func mapping(_ data : Any?)->Self?{
//        return self.deserialize(from: data  as? Dictionary)
//    }
//}
//extension Array : Mappable{
//    static func mapping(_ data : Any?)->Self?{
//        return self.deserialize(from: data as? [Any]) as? Self
//    }
//}
//extension Array  where Element : Mappable{
//    
//    static func mapping(_ data : Any?)->Self?{
//        return self.deserialize(from: data as? [Any]) as? Self
//    }
//}

/*
 public extension Array where Element: HandyJSON {
 
 /// if the JSON field finded by `designatedPath` in `json` is representing a array, such as `[{...}, {...}, {...}]`,
 /// this method converts it to a Models array
 public static func deserialize(from json: String?, designatedPath: String? = nil) -> [Element?]? {
 return JSONDeserializer<Element>.deserializeModelArrayFrom(json: json, designatedPath: designatedPath)
 }
 
 /// deserialize model array from NSArray
 public static func deserialize(from array: NSArray?) -> [Element?]? {
 return JSONDeserializer<Element>.deserializeModelArrayFrom(array: array)
 }
 
 /// deserialize model array from array
 public static func deserialize(from array: [Any]?) -> [Element?]? {
 return JSONDeserializer<Element>.deserializeModelArrayFrom(array: array)
 }
 }

 */
