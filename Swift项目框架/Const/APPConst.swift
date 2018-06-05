//
//  APPConst.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

public struct APP {
    
  fileprivate init(){}
    
  static var appBundleID: String? { return Bundle.main.bundleIdentifier }
  static let appVersion = 1.0
  static let apiVersion = 1.0
    
}


