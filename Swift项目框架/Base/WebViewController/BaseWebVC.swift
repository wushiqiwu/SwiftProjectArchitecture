//
//  BaseWebVC.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/9/27.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit
import WebKit
import MJRefresh

class BaseWebVC : BaseViewController{
    
    var url : String?
    var localPath : String?
    var webView : WKWebView!
    var progessView : UIProgressView!
    var canGoBack: Bool{ get{ return webView.canGoBack }}
    var webScrollView : UIScrollView{ get{  return webView.value(forKey: "scrollView") as! UIScrollView}}
    var bridgeController : WKWebViewJavascriptBridge?
    fileprivate var handles : [WebInteractionProtocol]?      //通过自定义URL交互的协议
    
    deinit {
        webScrollView.mj_header = nil
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
        webView.scrollView.delegate = nil;
        webView.stopLoading()
        webView.removeFromSuperview()
        webView = nil;
        let storage = HTTPCookieStorage.shared
        if let cookies = storage.cookies{
            for cookie in cookies {
                storage.deleteCookie(cookie)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSubViews()
        configInteraction()
        addObserver()
        loadOriginalUrl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.height = view.height
    }
    
    fileprivate func drawSubViews() {
        
        webView                      = WKWebView.init(frame: self.view.bounds)
        webView.uiDelegate           = self;
        webView.navigationDelegate   = self
        webView.backgroundColor      = UIColor.white
        view.addSubview(webView)

        //进度条
        progessView = UIProgressView.init(frame: CGRect.init(x: -1, y: 0, width: APP.screenWidth - 1, height: 1))
        progessView.progressViewStyle   = .bar
        progessView.trackTintColor      = UIColor.clear
        progessView.tintColor           = UIColor.RGB(r: 97, g: 173, b: 248)
        progessView.transform           = CGAffineTransform.init(scaleX: 1.0, y: 1.2)
        progessView.layer.cornerRadius  = 1.0
        progessView.layer.masksToBounds = true
        view.addSubview(progessView)
        
        //顶部刷新
        webScrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [unowned self] in
            self.loadOriginalUrl()
        })
    }
    
    fileprivate func configInteraction(){
        //        handles = XX
        configWebBridgeController()
    }
    
    //加载原URL
    func loadOriginalUrl(){
        
        if let temp = url , let URL = URL.init(string: temp){ //URL
            webView.load(URLRequest(url: URL))
        }else if let temp = localPath , let URL = URL.init(string:temp){ //本地
            webView.loadFileURL(URL, allowingReadAccessTo: URL)
        }
    }
    
    func goBack(){ if webView.canGoBack{ webView.goBack()} }
    
    fileprivate func addObserver(){
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
}


//MARK:- WKUIDelegate
extension BaseWebVC : WKUIDelegate{
    
    func webViewDidClose(_ webView: WKWebView) {
        webScrollView.mj_header.endRefreshing()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let cancel = AlertHandel.handel(withTitle: "取消") { completionHandler() }
        let confim = AlertHandel.handel(withTitle: "确定") { completionHandler() }
        AlertTool.showAlert(alertTitle: "温馨提示", message: message, cancel: cancel, confim: confim, other: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let cancel = AlertHandel.handel(withTitle: "取消") { completionHandler(false) }
        let confim = AlertHandel.handel(withTitle: "确定") { completionHandler(true)}
        AlertTool.showAlert(alertTitle: "温馨提示", message: message, cancel: cancel, confim: confim, other: nil)
    }
    
    //    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    //
    //    }
    
    //WKWebView将要打开一个新的链接
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if  let _ = navigationAction.targetFrame?.isMainFrame,
            let _ = navigationAction.request.url?.relativeString{
            webView.load(navigationAction.request)
        }
        return nil
    }
}

//MARK:- WKNavigationDelegate
extension BaseWebVC : WKNavigationDelegate{
    
    //已经开始
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    //导航事件,要跳转前操作
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let handlesArray = handles{
            for hanlde in handlesArray{
                if hanlde .handleInteraction(request: navigationAction.request) == false {
                    decisionHandler(.cancel)
                    break
                }
            }
        }
        decisionHandler(.allow)
    }
    
    //收到响应时是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    //加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progessView.setProgress(0, animated: false)
        webScrollView.mj_header.endRefreshing()
    }
    
    //加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progessView.setProgress(0, animated: false)
        webScrollView.mj_header.endRefreshing()
    }
    
    //HTTPS证书
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let trust = challenge.protectionSpace.serverTrust{
            let credential = URLCredential.init(trust: trust)
            completionHandler(.useCredential,credential)
            return
        }
        completionHandler(.cancelAuthenticationChallenge,nil)
    }
}

//MARK:- Observer
extension BaseWebVC{
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let temp = keyPath , temp == "estimatedProgress",let newPargress = change?[NSKeyValueChangeKey(rawValue: "new")] as? Float{
            progessView.setProgress(newPargress, animated: true)
        }
        
    }
}
