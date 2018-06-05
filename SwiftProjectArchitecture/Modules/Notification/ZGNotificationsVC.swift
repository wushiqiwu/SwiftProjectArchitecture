//
//  ZGNotificationsVC.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/28.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit
import RxDataSources

class ZGNotificationsVC: BaseViewController {

    lazy var viewModel = ZGNotificationViewModel()
    lazy var tableView : UITableView = {
         UITableView.link.frame(0, 10, APP.screenWidth, APP.screenHeight - 10)
        .rowHeight(100.0)
        .tableFooterView(UIView())
//        .delegate(self)
//        .dataSource(self)
        .base
    }()
    let data = RxTableViewSectionedReloadDataSource<SectionModel<String,ZGNotificationsModel>>(configureCell: { (section, tabel, index, model) -> UITableViewCell in
        var cell = tabel.dequeueReusableCell(withClass: ZGNotificationCell.self)
        if cell == nil {
            cell = ZGNotificationCell(style: .default, reuseIdentifier: String(describing:ZGNotificationCell.self))
        }
        cell?.model = model
        return cell!
    })
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "通知公告"
        drawSubView()
        configBind()
    }

    fileprivate func drawSubView(){
        
        view.addSubview(tableView)
       
        tableView.addFooterRefresh(viewModel.footerRefresh)
    }
    
    fileprivate func configBind(){
        
        let input = ZGNotificationViewModel.Input.init(tableView: tableView)
        let outPut = viewModel.transform(input: input)
    }

}


//extension ZGNotificationsVC : UITableViewDelegate,UITableViewDataSource{
//
//}
