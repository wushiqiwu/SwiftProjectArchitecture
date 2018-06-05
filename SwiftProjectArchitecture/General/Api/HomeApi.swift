//
//  HomeApi.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/4.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit
import RxSwift

extension Api{
    
    static func userLogin(  phone : String,  code : String) -> Observable<UserModel>{
        
        return Observable<UserModel>.create({ (obsever) -> Disposable in
            
            let params  = [
                "phone" : phone,
                "code"  : code,
                ]
            
           let task = Requester().post().url("/mainapp/v1/user/login").params(params).mapper(UserModel.self).start { (flag, obj) in
                guard flag , let data = obj.mapObj as? UserModel else{
                    obsever.onError(ApiError.requestError(msg:obj.message))
                    return
                }
                obsever.onNext(data)
                obsever.onCompleted()
            }
            
                return Disposables.create {
                    task.cancel()
                }
            })
            .share()
        }
    
    static func getNoticeListWithPage(  page : Int,  size : Int) -> Observable<[ZGNotificationsModel]>{
        

        return Observable<[ZGNotificationsModel]>.create({ (obsever) -> Disposable in
            
            let url = "/mainapp/v1/notice?page=\(page)&size=\(size)"
    
            let task = Requester().url(url).mapper([ZGNotificationsModel].self).start { (flag, obj) in
                guard flag , let data = obj.mapObj as? [ZGNotificationsModel] else{
                    obsever.onError(ApiError.requestError(msg:obj.message))
                    return
                }
                obsever.onNext(data)
                obsever.onCompleted()
            }
            
            return Disposables.create {
                task.cancel()
            }
        })
            .share()
    }
}


/*
 NSDictionary *requestDict = @{@"phone":phone,@"code":code,@"client_guid":[ZGCommonTool getClientID],@"client_app_version":ZGCurrentVersion,@"client_platform":@"ios",@"client_mobile":[ZGCommonTool iphoneType]};
 ZGRequestObject *request = [ZGRequestObject new];
 request.data = requestDict;
 NSString *urlStr = [NSString stringWithFormat:@"%@%@",ZGBaseURL,@"/mainapp/v1/user/login"];
 [self postWithUrl:urlStr param:request callback:callBack];
 */
