//
//  PhotoBrowserTool.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/11/23.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation
import SKPhotoBrowser

struct PhotoBrowserTool {
    
    static func browsing(with images : [UIImage], fromVC vc : UIViewController ,currentPage page : Int?){
        
        guard images.count > 0 else {return }

        let models = images.map {  SKPhoto.photoWithImage($0) }
        let browser = SKPhotoBrowser(photos: models)
        browser.initializePageIndex(page ?? 0)
//        browser.showToolbar(bool: true) 要删除的
        vc.present(browser, animated: true, completion: nil)
    }
    
    static func browsing(with urls : [String], fromVC vc : UIViewController ,currentPage page : Int?){
        
        guard urls.count == 0 else {return }
        
        let models = urls.map {  SKPhoto.photoWithImageURL($0) }
        let browser = SKPhotoBrowser(photos: models)
        browser.initializePageIndex(page ?? 0)
//        browser.showToolbar(bool: true) 要删除的
        vc.present(browser, animated: true, completion: nil)
    }
    
    fileprivate init(){}
}
