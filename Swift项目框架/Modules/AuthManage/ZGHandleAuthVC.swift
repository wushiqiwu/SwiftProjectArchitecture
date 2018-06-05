//
//  ZGHandleAuthVC.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/24.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit
import RxSwift

class ZGHandleAuthVC: UIViewController {
    
    class AuthItemView: UIView {
        
        lazy var titleLabel : UILabel = {
            UILabel.link.frame(0, 0, 100, self.height).textColor(.black).font(UIFont.size14).base
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(titleLabel)
            backgroundColor = .white
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    fileprivate static let itemHeight : CGFloat =  45.0
    
    lazy var name : UITextField = {
        return UITextField.link.frame(0, 0, APP.screenWidth * 0.5, CGFloat(ZGHandleAuthVC.itemHeight)).textColor(.black).font(UIFont.size12).base
    }()
    lazy var phone : UITextField = {
        return UITextField.link.frame(0, 0, APP.screenWidth * 0.5, CGFloat(ZGHandleAuthVC.itemHeight)).textColor(.black).font(UIFont.size12).base
    }()
    lazy var identity : UITextField = {
        return UITextField.link.frame(0, 0, APP.screenWidth * 0.5, CGFloat(ZGHandleAuthVC.itemHeight)).textColor(.black).font(UIFont.size12).base
    }()
    lazy var date : UITextField = {
        return UITextField.link.frame(0, 0, APP.screenWidth * 0.5, CGFloat(ZGHandleAuthVC.itemHeight)).textColor(.black).font(UIFont.size12).base
    }()
    lazy var face : UITextField = {
        return UITextField.link.frame(0, 0, APP.screenWidth * 0.5, CGFloat(ZGHandleAuthVC.itemHeight)).textColor(.black).font(UIFont.size12).base
    }()
    lazy var confimButton : UIButton = {
        return UIButton.link.frame(APP.screenWidth * 0.1, 0, APP.screenWidth * 0.8, CGFloat(ZGHandleAuthVC.itemHeight)).font(UIFont.size14).nomalStateTitleColor(.white).bgColor(.red).nomalStateTitle("提交").base
    }()
    
    var viewModel : ZGAuthViewModel!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        drawSubView()
        configBind()
        
    }
    
    fileprivate func configBind(){
        
        viewModel = ZGAuthViewModel()
        
        let inputs = ZGAuthViewModel.Input(name: name,
                                           phone: phone,
                                           identity: identity,
                                           date: date,
                                           face: face,
                                           button: confimButton)
        
        let outputs = viewModel.transform(input: inputs)
        
        //按钮生效
        outputs.invaildConfimButton.bind(to: self.confimButton.rx.isEnabled).disposed(by: bag)
        outputs.invaildConfimButton.map{ $0 ? UIColor.blue : UIColor.red }.bind(to: self.confimButton.rx.backgroundColor).disposed(by: bag)
        
        
        //点击后，进行网络请求
        outputs.data.bind { (model) in
            print(model)
        }.disposed(by: bag)

        //弹窗
        outputs.tips.subscribe(onNext: { (text) in
            print("1:" + text)
        }).disposed(by: bag)
     
    }
    

    fileprivate func drawSubView(){
        
        let titles = ["姓名","手机号码","身份","授权结束日期","人脸照片"]
        let rightViews = [name,phone,identity,date,face]
        var lastItem : AuthItemView?
        
        zip(titles, rightViews).forEach { (title,rightView) in
            
            let item = AuthItemView.init(frame: CGRect(x: 20,
                                                       y: ((lastItem?.maxY) != nil) ? lastItem!.maxY + CGFloat(15.0) : CGFloat(40.0),
                                                       width: APP.screenWidth - 40,
                                                       height: ZGHandleAuthVC.itemHeight))
            item.titleLabel.text = title
            rightView.x = item.width - 10 - rightView.width
            item.addSubview(rightView)
            view.addSubview(item)
            lastItem = item
        }
        
        
        //按钮
        confimButton.y = lastItem!.maxY + 20.0
        view.addSubview(confimButton)
    }
    
}
