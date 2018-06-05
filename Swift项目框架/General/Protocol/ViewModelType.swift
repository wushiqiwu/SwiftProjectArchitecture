//
//  ViewModelType.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/24.
//  Copyright © 2018年 wushiqi. All rights reserved.
//  Rx+MVVM ： ViewModel协议

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input : Input) -> Output
}
