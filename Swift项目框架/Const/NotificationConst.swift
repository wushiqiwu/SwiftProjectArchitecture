//
//  NotificationConst.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

struct APPNotification{
    fileprivate init(){}
}

//MARK: - 测试扩展
extension APPNotification{
  static let Text = Notification.Name.init("com.项目名.通知名")
}
