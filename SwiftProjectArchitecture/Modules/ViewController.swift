//
//  ViewController.swift
//  SwiftProjectArchitecture
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tool : PhotosChooseTool = {[unowned self] in
        let temp =  PhotosChooseTool.init(viewController: self )
        temp.choosingHandle = { [unowned self](chooser : PhotosChooseTool , images : [UIImage]) in
            print(chooser.selectedPhotos)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                PhotoBrowserTool.browsing(with: chooser.selectedPhotos, fromVC: self, currentPage: 1)
            })
        }
        return temp
        }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        Api.userLogin(phone: "18588466685", code: "9999", completion: { (model) in
//              print("登录成功")
//              print(model)
//        }, failure: {(code) in
//             print("登录失败")
//              print(code)
//        })

 
//        let label = UILabel.link.font(UIFont.size16)
//            .attributedText(NSAttributedString(string: "eqweqeqweqweqweqweqweqweqweqweqweqweqweqweqweqweqweqweqweqeqeqewqeweqeqwesadkjahdkjashdkajshdkashdkashdaskjdhaskjdhaueqwqu123", attributes: [.font : UIFont.size16 , .foregroundColor : UIColor.black]))
////            .textColor(.blue)
//            .bgColor(.red)
//            .frame(100, 100, 100, 0)
//            .addToView(view)
//            .numberOfLines(0)
//            .base
//        print("11111111111111")
//        print(label.height)
//        label.height = label.attributedTextHeight(width: label.width)
//        print(label.height)
        
        
        
        
//        //带缓存+映射 的 网络请求
//        Requester().url("XXXXX").needCache(true).mapper([AddressModel].self).start { (flag, obj) in
//
//            guard flag else{
//                print("请求失败")
//                return;
//            }
//
//            if let data = obj.mapObj as? [AddressModel]{
//                print( "用户地址为: " + data.map{$0.address!}.description )
//            }
//        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        tool.open()
//        present(RXSwfitExerciseViewController(), animated: true, completion: nil)
        TestPopupView().show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
