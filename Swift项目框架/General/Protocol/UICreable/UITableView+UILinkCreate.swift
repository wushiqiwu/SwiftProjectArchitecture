//
//  UITableView+UICreable.swift
//  点点汇
//
//  Created by wushiqi on 2017/12/6.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension LinkCreator where Base : UITableView{
    
    @discardableResult
    public func dataSource(_ value: UITableViewDataSource?) -> LinkCreator {
        base.dataSource = value
        return self
    }
    
    @discardableResult
    public func delegate(_ value: UITableViewDelegate?) -> LinkCreator {
        base.delegate = value
        return self
    }
    
    @discardableResult
    public func rowHeight(_ value: CGFloat) -> LinkCreator {
        base.rowHeight = value
        return self
    }
    
    @discardableResult
    public func sectionHeaderHeight(_ value: CGFloat) -> LinkCreator {
        base.sectionHeaderHeight = value
        return self
    }
    
    @discardableResult
    public func sectionFooterHeight(_ value: CGFloat) -> LinkCreator {
        base.sectionFooterHeight = value
        return self
    }
    
    @available(iOS 7.0, *)public func estimatedRowHeight(_ value: CGFloat) -> LinkCreator {
        base.estimatedRowHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    @discardableResult
    public func estimatedSectionHeaderHeight(_ value: CGFloat) -> LinkCreator {
        base.estimatedSectionHeaderHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    @discardableResult
    public func estimatedSectionFooterHeight(_ value: CGFloat) -> LinkCreator {
        base.estimatedSectionFooterHeight = value
        return self
    }
    
    @available(iOS 7.0, *)
    @discardableResult
    public func separatorInset(_ value: UIEdgeInsets) -> LinkCreator {
        base.separatorInset = value
        return self
    }
    
    @available(iOS 3.2, *)
    @discardableResult
    public func backgroundView(_ value: UIView?) -> LinkCreator {
        base.backgroundView = value
        return self
    }
    
    @discardableResult
    public func sectionIndexMinimumDisplayRowCount(_ value: Int) -> LinkCreator {
        base.sectionIndexMinimumDisplayRowCount = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func sectionIndexColor(_ value: UIColor?) -> LinkCreator {
        base.sectionIndexColor = value
        return self
    }
    
    @available(iOS 7.0, *)
    @discardableResult
    public func sectionIndexBackgroundColor(_ value: UIColor?) -> LinkCreator {
        base.sectionIndexBackgroundColor = value
        return self
    }
    
    @available(iOS 6.0, *)
    @discardableResult
    public func sectionIndexTrackingBackgroundColor(_ value: UIColor?) -> LinkCreator {
        base.sectionIndexTrackingBackgroundColor = value
        return self
    }
    
    @discardableResult
    public func separatorStyle(_ value: UITableViewCellSeparatorStyle) -> LinkCreator {
        base.separatorStyle = value
        return self
    }
    
    @discardableResult
    public func separatorColor(_ value: UIColor?) -> LinkCreator {
        base.separatorColor = value
        return self
    }
    
    @available(iOS 8.0, *)
    @discardableResult
    public func separatorEffect(_ value: UIVisualEffect?) -> LinkCreator {
        base.separatorEffect = value
        return self
    }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func cellLayoutMarginsFollowReadableWidth(_ value: Bool) -> LinkCreator {
        base.cellLayoutMarginsFollowReadableWidth = value
        return self
    }
    
    @discardableResult
    public func tableHeaderView(_ value: UIView?) -> LinkCreator {
        base.tableHeaderView = value
        return self
    }
    
    @discardableResult
    public func tableFooterView(_ value: UIView?) -> LinkCreator {
        base.tableFooterView = value
        return self
    }
    
    
    @available(iOS 9.0, *)
    @discardableResult
    public func remembersLastFocusedIndexPath(_ value: Bool) -> LinkCreator {
        base.remembersLastFocusedIndexPath = value
        return self
    }
}
