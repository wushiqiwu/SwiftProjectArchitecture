//
//  BaseNavigationController.swift
//  汇享天下Swift
//
//  Created by wushiqi on 2017/8/24.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super .pushViewController(viewController, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
