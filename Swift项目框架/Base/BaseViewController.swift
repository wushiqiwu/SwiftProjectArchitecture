//
//  BaseViewController.swift
//  汇享天下Swift
//
//  Created by wushiqi on 2017/8/24.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {

    override func viewDidLoad() {
        
        edgesForExtendedLayout = UIRectEdge();
        tabBarController?.tabBar.isTranslucent = false;
        navigationController?.navigationBar.isTranslucent = false;
        
        super.viewDidLoad()
//         view.backgroundColor = ViewDefaultColor //要删除的
         addCustomBackStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//MARK: - UI
extension BaseViewController{
    
    func addCustomBackStyle()  {
        
        if let count = navigationController?.viewControllers.count ,count < 2 { return }

        let back = UIButton.init(type: .custom)
        back.frame = CGRect.init(x: 0, y: 0, width: 50, height: 30)
        back.setImage(UIImage.init(named: "home_back_icon"), for: .normal)
        back.setImage(UIImage.init(named: "home_back_icon"), for: .selected)
        back.contentHorizontalAlignment  = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: back)
        
        back.addAction {[unowned self] (button) in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
