//
//  Requester.swift
//  点点汇
//
//  Created by wushiqi on 2017/9/22.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Alamofire

class Requester {
    
    typealias Params = [String : Any]
    typealias ReponseBlock = ((_ isSuccess : Bool ,_ obj : ResponseObject)->Void)?
    
    fileprivate var baseUrl = Environment.single.appBaseURL
    fileprivate var url = ""
    fileprivate var params : Params?
    fileprivate var requestMethod = HTTPMethod.get
    fileprivate var paramsEncoding  : ParameterEncoding = URLEncoding.default
    fileprivate var mapperType : Mappable.Type?
    fileprivate var needCahe = false
    fileprivate var showMsg  = true
    fileprivate var showHUD  = false
    
    //项目内参数
    fileprivate static let  RelistErrCode = 1006 //重新登录Code
    lazy var identifier = {[unowned self] () -> String in
        let temp = "\n" + self.requestMethod.rawValue + ":" + self.baseUrl + self.url + "\nDate:" + Date().description + "\n"
        return temp
        }()
    
    //请求缓存到本地的路径
    lazy var path = {[unowned self] () -> String in
        var temp = self.requestMethod.rawValue + self.baseUrl + self.url
        temp = temp.replacingOccurrences(of: "/", with: "_")
        temp = temp.replacingOccurrences(of: ":", with: "_")
        return temp
    }()
    
    fileprivate var dataRequst : DataRequest?
    
    deinit {
        print(self.identifier+"\nRequestTool释放")
    }
}

//MARK:- 开始请求
extension Requester{
    
    @discardableResult
    func start(result : ReponseBlock) -> Self{
        
        needGetCache(result) //是否需要获取缓存过的请求
        RequestManager.share[self] = self
        
        if showHUD {  HUDTool.showHUD() }
        dataRequst = getRequest()
        dataRequst?.responseJSON {[unowned self](alamofireRes) in
            switch alamofireRes.result{
            case .success( let json):
                
                if self.showHUD { HUDTool.hiddenHUD() }
                let obj = ResponseObject()
                
                //返回的是字典类型
                if let dic = json as? Dictionary<String,Any>{
                    
                    if let temp = dic["errCode"] as? Int    { obj.errCode = temp  }
                    if let temp = dic["errMsg"]  as? String { obj.message  = temp }
                    
                    //需要重新登录
                    if obj.errCode == Requester.RelistErrCode{
                        //要删除的
                        if self.showMsg { HUDTool.showError(obj.message) }
                        result?(false,obj)
                        print("需要重新登录") //要删除的,这里要改重新登录
                        return
                    }
                    
                    //Code != 0
                    if obj.errCode > 0 {
                        if self.showMsg { HUDTool.showError(obj.message) }
                        result?(false,obj)
                        return
                    }
                    
                    //如果有data Key
                    if let data = dic["data"]{
                        obj.data = data
                        if let type = self.mapperType{ obj.mapObj = type.mapping(obj.data) }//映射
                        self.needSetCache(obj.data) //是否需要缓存
                    }
                    result?(true,obj)
                    
                }else if let array = json as? Array<Any>{ //返回的是数组类型
                    
                    obj.data = array
                    if let type = self.mapperType{ obj.mapObj = type.mapping(obj.data) }//映射
                    result?(true,obj)
                    self.needSetCache(obj.data) //是否需要缓存
                    
                }else{
                    
                    obj.message  = "返回数据有误"
                    if self.showMsg { HUDTool.showError(obj.message) }
                    result?(false,obj)
                }
                
                RequestManager.share[self] = nil
                
            case .failure( let error):
                
                if self.showHUD { HUDTool.hiddenHUD() }
                
     
                //这次错误属于，取消了请求
                if( (error as NSError).code == NSURLErrorCancelled ){
                    RequestManager.share[self] = nil
                    return
                }
                
                let obj = ResponseObject()
                obj.message = "服务器开了小差,请稍后再试!"
                
                if self.showMsg { HUDTool.showError(obj.message) }
                result?(false,obj)
                RequestManager.share[self] = nil
                debugPrint("请求发生错误:  \(error)")
            }
        }
        return self
    }
    
    fileprivate func getRequest() -> DataRequest{
        
        let finalUrl    = baseUrl+url
        var finalParams = publicParams()
        if let temp = params{ finalParams.merge(temp){$1} }
        
        debugPrint(self)
        
        return Alamofire.request(finalUrl,
                                 method: requestMethod ,
                                 parameters: finalParams,
                                 encoding: paramsEncoding,
                                 headers: hettpHeader)
    }
}



//MARK: - 缓存
extension Requester{
    
    //获取上次请求成功并且缓存的数据
    fileprivate func needGetCache(_ result:ReponseBlock){
        guard  let block = result  , needCahe else {  return  }
        guard  let json = RequestManager.share.cache.getCacheData(with: self) else{ return }
        let obj = ResponseObject()
        obj.errCode = 0
        obj.message = ""
        obj.data    = json
        if let type = self.mapperType{ obj.mapObj = type.mapping(obj.data) }//映射
        printLog(self.identifier + " : 获取了本地缓存数据")
        block(true,obj)
    }
    
    //设置本次缓存(如果请求成功了)
    fileprivate func needSetCache(_ responseData : Any?){
        guard  let temp = responseData  , needCahe else {  return  }
        RequestManager.share.cache.setCacheData(with: self, json: temp)
    }
}




//MARK:- 配置公共参数
extension Requester{

    var hettpHeader : HTTPHeaders{
        get{
            var headers = HTTPHeaders()
            if let user = UserModel.getCacheData() {
                headers["authorization"] = "Bearer " + user.token
            }
            return headers
        }
    }
    
    func publicParams() -> Params{
        return [:]
    }
}

//MARK:- 链式覆盖方法
extension Requester{
    
    func url(_ url : String) -> Self{ self.url = url;  return self }
    func get() -> Self{ self.requestMethod = .get; return self }
    func post() -> Self{ self.requestMethod = .post; return self }
    func delete() -> Self{ self.requestMethod = .delete; return self }
    func params(_ dic : Params) -> Self { self.params = dic; return self }
    func paramsEncoding(_ encoding : ParameterEncoding) -> Self{  self.paramsEncoding = encoding;  return self }
    func mapper(_ type : Mappable.Type)-> Self {self.mapperType = type ; return self }
    func needCache(_ isNeed : Bool)->Self { self.needCahe = isNeed ;  return self}
    func showMsg(_ isShow : Bool )->Self  { self.showMsg = isShow; return self }
}


//MARK:- 常用参数
extension Requester{
    
    //参数JSON编码
    func paramsJsonEncoding()->Self{ return paramsEncoding(JSONEncoding.default)}
    func showHUD(_ isShow : Bool) -> Self { showHUD = isShow  ; return self  }
}

//MARK:- 请求的取消
extension Requester{
    
    var isRuning : Bool{
        guard let task = dataRequst!.task , dataRequst != nil else {  return  false }
        return task.state == .running
    }
    func cancel(){
        guard  isRuning  else { return }
        dataRequst?.cancel()
    }
}

//MARK: - 输出
extension Requester : CustomDebugStringConvertible{
    
    var debugDescription: String{
        var finalParams = publicParams()
        if params != nil{  finalParams.merge(params!){$1} }
        return "***********  Requester  *********** \n"
            + "Method: \(requestMethod) \n"
            + "URL: \(url) \n"
            + "HTTPHeader: \(hettpHeader) \n"
            + "Params : \(String(describing: finalParams)) \n"
    }
}




