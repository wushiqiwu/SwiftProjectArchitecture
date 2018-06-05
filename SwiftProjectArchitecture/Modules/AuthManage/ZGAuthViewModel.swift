//
//  ZGAuthViewModel.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/24.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ZGAuthViewModel : ViewModelType {
    
    struct Input {
        let name        : UITextField
        let phone       : UITextField
        let identity    : UITextField
        let date        : UITextField
        let face        : UITextField
        let button      : UIButton
    }
    
    struct Output {
        var invaildConfimButton : Observable<Bool>
        var data : Observable<ZGAuthModel>
        var tips : Observable<String>
    }

    let tips = PublishSubject<String>()
    
    func authRequest(name : String,phone : String,identity : String,date : String,face : String) -> Observable<ZGAuthModel>{
        return Observable<ZGAuthModel>.create({ (obs) -> Disposable in
            obs.onNext(ZGAuthModel(name: name, phone: phone, identity: identity, date: date, face: face))
            return Disposables.create()
        })
        .retry(3)
    }
    
    func transform(input: Input) -> Output {
        
        //按钮是否有效
        let resources = [
            input.name.rx.text.orEmpty,
            input.phone.rx.text.orEmpty,
            input.identity.rx.text.orEmpty,
            input.date.rx.text.orEmpty,
            input.face.rx.text.orEmpty
        ]
        
        let invaildConfimButton =  Observable<Bool>.combineLatest(resources){
            for str in $0{
                if str.count == 0{
                    return false
                }
            }
            return true
        }.observeOn(MainScheduler.instance)
         .share()
        

        //模拟网络请求
        let data =  input.button.rx.tap
            .filter{ self.headleInpustResult(input) }
            .flatMapLatest{  _ in
                self.authRequest(name: input.name.text!,
                                 phone: input.phone.text!,
                                 identity: input.identity.text!,
                                 date: input.date.text!,
                                 face: input.face.text!)
            }
            .share(replay: 1, scope: .whileConnected)

        return Output.init(invaildConfimButton: invaildConfimButton,data: data,tips: tips.share().asDriver(onErrorJustReturn: "").asObservable())
    }
    
    fileprivate func headleInpustResult(_ i : Input)->Bool{
        print("headleInpustResult")
        if i.phone.text?.count != 11{
            tips.onNext("手机号码必须11位")
            return false
        }
        if i.name.text?.count != 6{
            tips.onNext("用户名必须大于6位")
            return false
        }
        return true
    }
}
