//
//  DatabaseService.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/30.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import Foundation
import SQLite

struct DatabaseService {
    
    var database : Connection!
    
    init() {
        do{
            let path = NSHomeDirectory() + "/Documents/testDB.sqlite3" //要删除的，这里要改数据库名字
            print(path) //要删除的
            database = try Connection(path)
        }catch{ print("DataBase初始化失败:\(error.localizedDescription)") }
    }
}

/*
func saveModel(){
    
    var allModels = [TestModel]()
    allModels.append(TestModel(name: "name_1", age: 1, address: "addraee_1", email: "email_1"))
    allModels.append(TestModel(name: "name_2", age: 2, address: "addraee_2", email: nil))
    allModels.append(TestModel(name: "name_3", age: 3, address: "addraee_3", email: "email_3"))
    allModels.append(TestModel(name: "name_4", age: 4, address: "addraee_4", email: nil))
    llModels.append(TestModel(name: "name_5", age: 5, address: "addraee_5", email: "email_5"))
    
    let table = TestTable()
    for model in allModels{
        table.insert(model)
    }
}


func getModel(){
    
    print("\n*********************TsetTable*********************")
    let allModels = TestTable().allModels()
    allModels.forEach{print($0)}
}


func updateModel(){
    
    let model = TestModel(name: "name_2", age: 2, address: "addraee_2", email: "email_2")
    TestTable().update(model)
}

//测试
struct TestModel  : CustomDebugStringConvertible{
    var name : String
    var age : Int
    var address : String
    var email : String?
}

extension TestModel{
    var debugDescription: String{
        return name + "\t" + String(age) + "\t" + address + "\t" + (email ?? "NULL")
    }
}

struct TestTable {
    
    private let sqliteManager = DatabaseService()
    private let table    = Table("test")
    
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let age = Expression<Int>("age")
    let address = Expression<String>("address")
    let email  = Expression<String?>("email")
    init() {
        
        do{
            try sqliteManager.database.run(table.create(ifNotExists: true, block: { (builder) in
                builder.column(id, primaryKey: true)
                builder.column(name)
                builder.column(age)
                builder.column(address)
                builder.column(email,unique:true)
            }))
        }catch{ print(error)}
    }
    
    
    func insert(_ model : TestModel){
        
        if exist(model) { return }
        
        let task = table.insert(
            name <- model.name,
            age  <- model.age,
            address <- model.address,
            email <- model.email
        )
        do{
            try sqliteManager.database.run(task)
        }catch{ print("insertError: \(error)")}
    }
    
    
    func allModels()->[TestModel]{
        
        var allModels = [TestModel]()
        do{
            for row in try sqliteManager.database.prepare(table){
                let model = TestModel(name: row[name], age: row[age], address: row[address], email: row[email])
                allModels.append(model)
            }
        }catch{print("allModelsError: \(error)")}
        
        return allModels
    }
    
    
    func update(_ newModel : TestModel){
        
        let update =  table.filter(age == newModel.age).update(
            name <- newModel.name,
            address <- newModel.address,
            email <- newModel.email
        )
        do{
            try sqliteManager.database.run(update)
        }catch{print("updateError:\(error)")}
    }
    
    
    func exist(_ model : TestModel)->Bool{
        
        let temp = table.filter(
            name == model.name &&
                age == model.age &&
                address == model.address &&
                email == model.email
        )
        var result = 0
        do{
            result = try sqliteManager.database.scalar(temp.count)
        }catch{print(error)}
        return result != 0
    }
}

 */
