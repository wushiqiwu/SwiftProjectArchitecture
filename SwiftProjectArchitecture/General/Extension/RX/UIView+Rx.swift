//
//  UIView+Rx.swift
//  SwiftProjectArchitecture
//
//  Created by 吴施岐 on 2018/5/23.
//  Copyright © 2018年 wushiqi. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base : UIView{
    
    public var tapGesture : ControlEvent<UITapGestureRecognizer>{
        let tap = UITapGestureRecognizer()
        base.addGestureRecognizer(tap)
        base.isUserInteractionEnabled = true
        return tap.rx.event
    }
    
    
    public var backgroundColor: Binder<UIColor> {
        return Binder(self.base) { view, value in
            view.backgroundColor = value
        }
    }
            
}

