//
//  Extension+Rx.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/25.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import RxSwift
import RxCocoa

extension Observable{
    
    //MARK:-  网络请求使用: 只处理成功
    public func response(success: @escaping ((Observable.E) -> Swift.Void) ) -> Disposable{
        return self.subscribe(onNext: { (e) in
            success(e)
        }, onError:{ _ in },
           onCompleted: nil,
           onDisposed: nil)
    }
    
    //MARK:- 网络请求使用: 只处理成功和失败
    public func response(success: @escaping ((Observable.E) -> Swift.Void) , failure: @escaping ((Error) -> Swift.Void)) -> Disposable{
        return self.subscribe(onNext: { (e) in
            success(e)
        }, onError: { (error) in
            failure(error)
        }, onCompleted: nil, onDisposed: nil)
    }
}
