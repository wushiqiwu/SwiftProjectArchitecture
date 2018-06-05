//
//  BaseTableCell.swift
//  汇享天下Swift
//
//  Created by wushiqi on 2017/9/1.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //cell横线从左边开始
    func separatorInsetZero()  {
        separatorInset = UIEdgeInsets.zero
        layoutMargins  = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
    }
}
