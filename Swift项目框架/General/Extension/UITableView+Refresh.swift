//
//  UITableView+Refresh.swift
//  点点汇
//
//  Created by wushiqi on 2017/11/21.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa

//MARK: - Refresh
extension UIScrollView{
    
    func addHeaderRefresh( _ handel : @escaping ()->Void){
        
        let header = MJRefreshNormalHeader.init(refreshingBlock: handel)
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.stateLabel.isHidden = true;
        header?.arrowView.isHidden = true;
        header?.activityIndicatorViewStyle = .white;
        if let temp = header{
            mj_header = temp
        }
    }
    
    func addFooterRefresh( _ handel : @escaping ()->Void){
        
        let footer = MJRefreshAutoStateFooter.init(refreshingBlock: handel)
        footer?.setTitle("上拉加载", for: .idle)
        footer?.setTitle("正在加载...", for: .pulling)
        footer?.setTitle("正在加载...", for: .willRefresh)
        footer?.setTitle("正在加载...", for: .refreshing)
        footer?.setTitle("没有数据了!", for: .noMoreData)
        if let temp = footer{
            mj_footer = temp
        }
    }
}

extension Reactive where Base : UIScrollView{
    
    var headerRefresh : Observable<Void>{
        
        let publish = PublishSubject<Void>()
        let handel = {
            publish.onNext(())
        }
        let header = MJRefreshNormalHeader.init(refreshingBlock: handel)
        header?.lastUpdatedTimeLabel.isHidden = true;
        header?.stateLabel.isHidden = true;
        header?.arrowView.isHidden = true;
        header?.activityIndicatorViewStyle = .white;
        if let temp = header{
            base.mj_header = temp
        }
        
        return publish.asObserver().subscribeOn(MainScheduler.instance).share(replay: 0, scope: .whileConnected)
    }
    
    public var headerHidden: Binder<Bool> {
        return Binder(self.base) { view, value in
            if let header = view.mj_header{
                header.isHidden = value
            }
        }
    }
}
