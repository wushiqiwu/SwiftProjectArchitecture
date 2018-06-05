//
//  TestPopupView.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/6/4.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit

class TestPopupView: BasePopupView {
    
    override func drawSubView() {
        
        super.drawSubView()
        
        contentView.size = CGSize(width: APP.screenWidth * 0.5, height: APP.screenHeight * 0.5)
        
        UILabel.link.text("这是一个测试的弹窗视图").frame(0, 50, width, 30).textColor(.black).font(UIFont.size14).addToView(contentView)
        
        UIButton.link.nomalStateTitle("确定").nomalStateTitleColor(.red).addToView(contentView)
            .layout({ (maker) in
                maker.bottom.left.right.equalToSuperview()
                maker.height.equalTo(45.0)
            })
            .addAction({ [unowned self] _ in
                self.hidden()
            })

    }
    
}
