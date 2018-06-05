//
//  RXSwfitExerciseViewController.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/10.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum NetWorkError : Error{
    case aaa
}
class RXSwfitExerciseViewController: BaseViewController {
    
    let textF = UITextField()
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
//        func1()
        //        func2()
        //        func3()
        //        func4()
        //        func5()
        
        UIImageView.link
            .frame(0, 0, 100, 100)
            .bgColor(.red)
            .addToView(view)
            .base
            .rx
            .tapGesture
            .subscribe { [unowned self](e) in
                //             self.dismiss(animated: true, completion: nil)
                self.present(ZGNotificationsVC(), animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
    
    
    func getData(_ str : String) -> Observable<String>{
        return Observable<String>.create({ (o) -> Disposable in
            o.onNext("data : \(String(describing: str))")
            return  Disposables.create()
        })
    }
    
    func func5(){
        
        
        UIButton().rx.tap
        UITextField.link
            .frame(100, 100, 100, 30)
            .bgColor(.red)
            .addToView(view)
            .base
            .rx
            .text
            .orEmpty //字符串为nil的数据
            .skipWhile{ $0.count == 0 } //过滤输入内容为空的数据
            .debounce(0.5, scheduler: MainScheduler.instance) //每0.5秒一次搜索，过滤高频元素,避免多次调接口
            .flatMapLatest{ self.getData($0) } //调登录接口
            .subscribe { (e) in //获取登录的model
                print(e)
        }
        
    }
    
    func func4(){
        
        let bag = DisposeBag()
        let p1 = PublishSubject<String>()
        let p2 = PublishSubject<String>()
        let switchL = PublishSubject<Observable<String>>()
        
        switchL.switchLatest().subscribe { (e) in
            print(e)
            }.disposed(by: bag)
        
        switchL.onNext(p1)
        
        p1.onNext("P1 1")
        p2.onNext("p2 1")
        switchL.onNext(p2)
        p1.onNext("P1 2")
        p2.onNext("p2 2")
        
    }
    
    
    func  func3(){
        
        struct Player{
            var source : Variable<Int>
        }
        
        let p1 = Player(source: Variable(10))
        let p2 = Player(source: Variable(20))
        
        let publish = PublishSubject<Player>()
        publish.map { (p) -> Observable<Int> in
            print("flatMap")
            return p.source.asObservable()
        }
        publish.flatMap({ (p) -> Observable<Int> in
            print("flatMap")
            return p.source.asObservable()
        }).subscribe { (e) in
            print(e)
        }
        
        publish.onNext(p1)
        p1.source.value = 11
        p1.source.value = 12
        publish.onNext(p2)
        p1.source.value = 13
        p2.source.value = 21
        p2.source.value = 22
    }
    
    func func2(){
        
        //        PublishSubject<Int>.create { (o) -> Disposable in
        //            o.onNext(0)
        //            return Disposables.create()
        //        }.sub
        //        Observable<Int>.interval(1, scheduler: MainScheduler.instance).skipWhile{ $0 < 3 }
        //            .subscribe { (e) in
        //                print(e.element)
        //        }
    }
    
    
    
    func func1(){
        
        let label = UILabel.link.textColor(.red)
            .bgColor(.yellow)
            .frame(100, 100, 100, 100)
            .addToView(view)
            .numberOfLines(0)
            .font(UIFont.size16)
            .base
        
        
        Api.userLogin(phone: "18588466685", code: "9999")
            .map{ $0.user.user_phone }
            .response(success: { (phone) in
                label.text = phone
            }, failure: { (error) in
                switch error as! ApiError {
                case .requestError(let m):
                    print(m)
                }
            })
            .disposed(by: bag)
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        dismiss(animated: true, completion: nil)
    }
}

extension Reactive where Base : UIViewController{
    var isAAA : Binder<Bool> {
        return Binder.init(base, binding: { (vc, value) in
            vc.isEditing = value
        })
    }
}
