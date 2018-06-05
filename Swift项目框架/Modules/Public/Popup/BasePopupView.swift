//
//  BasePopupView.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/6/4.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import UIKit

protocol Popable {
    
    func show()
    func hidden()
    
}

class BasePopupView: UIView {

    var contentView : UIView!
    var backgroundView : UIView!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        drawSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawSubView(){
        
        backgroundView = UIView.init(frame: bounds)
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.5
        addSubview(backgroundView)
        
        contentView = UIView.init(frame: CGRect.zero)
        contentView.backgroundColor = .white
        addSubview(contentView)
    }
    
    override func layoutSubviews() {
        contentView.center = center
        backgroundView.center = center
    }
}


extension BasePopupView : Popable{
    
    
    func show() {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        contentView.transform = .init(scaleX: 0, y: 0)
        backgroundView.alpha  = 0
        keyWindow.addSubview(self)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.contentView.transform =  .identity
            self.backgroundView.alpha  =  0.5
        }) { (isAnimated) in
            
        }
    }
    
    func hidden() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.transform = .init(scaleX: 0, y: 0)
            self.backgroundView.alpha  = 0
        }) { (isAnimated) in
            self.removeFromSuperview()
        }
    }
}
