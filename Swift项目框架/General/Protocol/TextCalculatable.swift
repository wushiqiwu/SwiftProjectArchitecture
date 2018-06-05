//
//  TextCalculatable.swift
//  Swift项目框架
//
//  Created by 吴施岐 on 2018/5/7.
//  Copyright © 2018年 wushiqi. All rights reserved.
//  文本计算宽高

import Foundation

protocol TextCalculatable {
    
    func textHeight(width:CGFloat , font:UIFont)->CGFloat
    func textWidth(height:CGFloat , font:UIFont)->CGFloat
    func attributedTextHeight(width:CGFloat)->CGFloat
    func attributedTextWidth(height:CGFloat)->CGFloat
}

extension UILabel : TextCalculatable{}
extension TextCalculatable where Self : UILabel{
    
    //算宽
    func textWidth(height:CGFloat )->CGFloat{
        return textWidth(height: width, font: font)
    }
    func textWidth(height:CGFloat , font:UIFont)->CGFloat{
        guard  let text = text , text.count != 0  else {
            return 0
        }
        return (text as NSString).boundingRect(with: CGSize(width:CGFloat(MAXFLOAT), height: height),
                                               options: [.usesLineFragmentOrigin,.usesFontLeading],
                                               attributes: [.font : font], context: nil).size.width + 1
    }
    
    func attributedTextWidth(height:CGFloat)->CGFloat{
        guard  let text = attributedText, text.length != 0 else {
            return 0
        }
        return text.boundingRect(with: CGSize(width:CGFloat(MAXFLOAT), height: height), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size.width+1
    }
    
    
    //算高
    func textHeight(width:CGFloat )->CGFloat{
      return textHeight(width: width, font: font)
    }
    func textHeight(width:CGFloat , font:UIFont)->CGFloat{
        guard  let text = text , text.count != 0  else {
            return 0
        }
       return (text as NSString).boundingRect(with:CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                              options: [.usesLineFragmentOrigin,.usesFontLeading],
                                              attributes: [.font : font], context: nil).size.height + 1
    }
    
    
    func attributedTextHeight(width:CGFloat)->CGFloat{
        guard  let text = attributedText, text.length != 0 else {
            return 0
        }
        return text.boundingRect(with:CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size.height+1
    }
}


extension TextCalculatable where Self : UITextView{
    
    //算宽
    func textWidth(height:CGFloat )->CGFloat{
        guard let fontValue = font else{
            return 0
        }
        return textWidth(height: width, font: fontValue)
    }
    func textWidth(height:CGFloat , font:UIFont)->CGFloat{
        guard  let text = text , text.count != 0  else {
            return 0
        }
        return (text as NSString).boundingRect(with: CGSize(width:CGFloat(MAXFLOAT), height: height),
                                               options: [.usesLineFragmentOrigin,.usesFontLeading],
                                               attributes: [.font : font], context: nil).size.width + 1
    }
    
    func attributedTextWidth(height:CGFloat)->CGFloat{
        guard  let text = attributedText, text.length != 0 else {
            return 0
        }
        return text.boundingRect(with: CGSize(width:CGFloat(MAXFLOAT), height: height), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size.width+1
    }
    
    
    //算高
    func textHeight(width:CGFloat )->CGFloat{
        guard let fontValue = font else{
            return 0
        }
        return textHeight(width: width, font: fontValue)
    }
    func textHeight(width:CGFloat , font:UIFont)->CGFloat{
        guard  let text = text , text.count != 0  else {
            return 0
        }
        return (text as NSString).boundingRect(with:CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                               options: [.usesLineFragmentOrigin,.usesFontLeading],
                                               attributes: [.font : font], context: nil).size.height + 1
    }
    
    
    func attributedTextHeight(width:CGFloat)->CGFloat{
        guard  let text = attributedText, text.length != 0 else {
            return 0
        }
        return text.boundingRect(with:CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size.height+1
    }
}
