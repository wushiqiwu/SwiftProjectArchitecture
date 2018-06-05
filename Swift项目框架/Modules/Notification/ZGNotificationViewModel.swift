//
//  ZGNotificationViewModel.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/28.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ZGNotificationViewModel : ViewModelType {
    
    
    struct Input {
        var tableView : UITableView
        
    }
    
    
    struct Output {
        
    }
    
//    typealias Section = SectionModel<String,ZGNotificationsModel>
//
    let bag = DisposeBag()
//    let dataSource = RxTableViewSectionedReloadDataSource<Section>(configureCell: { (section, tabel, index, model) -> UITableViewCell in
//        var cell = tabel.dequeueReusableCell(withClass: ZGNotificationCell.self)
//        if cell == nil {
//            cell = ZGNotificationCell(style: .default, reuseIdentifier: String(describing:ZGNotificationCell.self))
//        }
//        cell?.model = model
//        return cell!
//    })
    
    var page = 0
    var input : Input?
    
    func transform(input: Input) -> Output {
        
        self.input = input
        

        //先登录
        Api.userLogin(phone: "18588466685", code: "9999")
            .response(success: { (user) in
                user.cacheSelf()
                input.tableView.mj_header.isHidden = user.user.uid.count <= 0
            }, failure: { (error) in
                print(error)
            })
            .disposed(by: bag)

        input.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotificationCell")
        
        //下拉刷新+网络请求
        let response = input.tableView.rx.headerRefresh.flatMapLatest{ _->  Observable<[ZGNotificationsModel]>  in
                print("刷新")
                self.page = self.page + 1
                return Api.getNoticeListWithPage(page:self.page, size: 20)
            }
            .asDriver(onErrorJustReturn: [])
        
        
        response.drive(input.tableView.rx.items(cellIdentifier: "NotificationCell")){ row,model,cell in
            cell.textLabel?.text = model.notice_title
        }.disposed(by: bag)
        
        
        response.drive(onNext: { (modelsArray) in
            input.tableView.mj_header.endRefreshing()
            if( modelsArray.count == 0 ){
                print("没数据")
                input.tableView.mj_header.isHidden = true
            }else{
                print("有数据")
                self.page = self.page - 1
                input.tableView.mj_header.isHidden = false
            }
        }, onCompleted: nil, onDisposed: nil)
        .disposed(by: bag)

        
        input.tableView.rx.modelSelected(ZGNotificationsModel.self).subscribe(onNext: { (model) in
            print(model.notice_title)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: bag)

        let outPut = Output.init()
        return outPut
    }
    
    func reqeustNoticeList(){
        
        if self.input == nil {return}
        
        self.page = page + 1
        //        Api.getNoticeListWithPage(page: page, size: 20)
        //            .map { [Section(model: "header1", items: $0)] }
        //            .response(success: { [weak self ](models) in
        //                self?.input?.tableView.rx.items(dataSource: models)
        //            }, failure: { [weak self ](error) in
        //                if( self == nil ){  return }
        //
        //                self!.page = self!.page - 1
        //            })
        ////            .bind(to: self.input!.tableView.rx.items(dataSource: dataSource))
        //            .dispose()
    }
    
    func footerRefresh(){
        self.reqeustNoticeList()
    }
}
