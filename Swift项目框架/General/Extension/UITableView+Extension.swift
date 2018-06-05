//
//  UITableView_Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/9/16.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import SnapKit

//MARK:- 初始化
extension UITableView{

    //约束创建
    class func creating<D>(style : UITableViewStyle,
                        delegate : D ,
                        superView : UIView?) -> UITableView where D : UITableViewDelegate &  UITableViewDataSource  {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.tableFooterView = UIView()
        
        if  let temp = superView{
            temp.addSubview(tableView)
            tableView.snp.makeConstraints { (maker) in
                maker.top.bottom.left.right.equalToSuperview()
            }
        }
        return tableView
    }
    
    //Frame创建
    class func creating<D>(style : UITableViewStyle,
                           delegate : D ,
                           superView : UIView?,
                           frame : CGRect?) -> UITableView where D : UITableViewDelegate &  UITableViewDataSource  {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.tableFooterView = UIView()
        
        if  let temp = superView{
            temp.addSubview(tableView)
        }
        
        if let temp = frame{
            tableView.frame = temp
        }
        return tableView
    }
}

