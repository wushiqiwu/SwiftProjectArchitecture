//
//  UIImageView+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension LinkCreator where Base : UIImageView{
    
    @discardableResult
    static public func create(_ imageName : String)->UIImageView{
        return UIImageView.init(image: UIImage.init(named: imageName))
    }
    
    @discardableResult
    static public func create(_ image : UIImage?)->UIImageView{
        return UIImageView.init(image: image)
    }
    
    // default is nil
    @discardableResult
    @available(iOS 3.0, *)
    public func highlightedImage(_ value: UIImage?) -> LinkCreator {
        base.highlightedImage = value
        return self
    }
    
    // default is NO
    @discardableResult
    public func highlighted(_ value: Bool) -> LinkCreator {
        base.isHighlighted = value
        return self
    }
    
    // these allow a set of images to be animated. the array may contain multiple copies of the same
    // The array must contain UIImages. Setting hides the single image. default is nil
    @discardableResult
    public func animationImages(_ value: [UIImage]?) -> LinkCreator {
        base.animationImages = value
        return self
    }
    
    // The array must contain UIImages. Setting hides the single image. default is nil
    @discardableResult
    @available(iOS 3.0, *)
    public func highlightedAnimationImages(_ value: [UIImage]?) -> LinkCreator {
        base.highlightedAnimationImages = value
        return self
    }
    
    // for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
    @discardableResult
    public func animationDuration(_ value: TimeInterval) -> LinkCreator {
        base.animationDuration = value
        return self
    }
    
    // 0 means infinite (default is 0)
    @discardableResult
    public func animationRepeatCount(_ value: Int) -> LinkCreator {
        base.animationRepeatCount = value
        return self
    }
}
