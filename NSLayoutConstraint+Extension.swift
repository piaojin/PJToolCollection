//
//  NSLayoutConstraint+Extension.swift
//  Swifter
//
//  Created by Zoey Weng on 2018/1/24.
//  Copyright © 2018年 Zoey Weng. All rights reserved.
//

import UIKit

// MARK: 获取上下左右NSLayoutConstraint
public extension UIView {
    var pj_constraints: [NSLayoutConstraint]? {
        return self.superview?.constraints
    }
    
    var pj_leftConstraint: NSLayoutConstraint? {
        return self.pj_getConstraint(firstAttribute: .left, secondAttribute: .leading)
    }
    
    var pj_rightConstraint: NSLayoutConstraint? {
        return self.pj_getConstraint(firstAttribute: .right, secondAttribute: .trailing)
    }
    
    var pj_topConstraint: NSLayoutConstraint? {
        return self.pj_getConstraint(firstAttribute: .top, secondAttribute: .top)
    }
    
    var pj_bottomConstraint: NSLayoutConstraint? {
        return self.pj_getConstraint(firstAttribute: .bottom, secondAttribute: .bottom)
    }
    
    var pj_widthConstraint: NSLayoutConstraint? {
        return self.constraints.filter({ (constraint) -> Bool in
            if constraint.firstAttribute == .width {
                if let object = constraint.firstItem, let objc = object as? NSObject, objc == self {
                    return true
                }
            } else if constraint.secondAttribute == .width {
                if let object = constraint.secondItem, let objc = object as? NSObject, objc == self {
                    return true
                }
            }
            return false
        }).first
    }
    
    var pj_heightConstraint: NSLayoutConstraint? {
        return self.constraints.filter({ (constraint) -> Bool in
            if constraint.firstAttribute == .height {
                if let object = constraint.firstItem, let objc = object as? NSObject, objc == self {
                    return true
                }
            } else if constraint.secondAttribute == .height {
                if let object = constraint.secondItem, let objc = object as? NSObject, objc == self {
                    return true
                }
            }
            return false
        }).first
    }
    
    // .right .trailing
    func pj_getConstraint(firstAttribute: NSLayoutAttribute, secondAttribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        return self.pj_constraints?.filter({ (constraint) -> Bool in
            if constraint.firstAttribute == firstAttribute || constraint.firstAttribute == secondAttribute {
                if let object = constraint.firstItem, let objc = object as? NSObject, objc == self {
                    return true
                }
            } else if constraint.secondAttribute == firstAttribute || constraint.secondAttribute == secondAttribute {
                if let object = constraint.secondItem, let objc = object as? NSObject, objc == self {
                    return true
                }
            }
            return false
        }).first
    }
}
