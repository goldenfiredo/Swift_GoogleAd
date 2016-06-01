//
//  Marquee.swift
//  Copyright (c) 2015 Du Limin. All rights reserved.
//

import UIKit

class Marquee {
    init(superview:UIView, text:String) {
        createMarquee(superview, text:text)
    }
    
    func createMarquee(superview:UIView, text:String) {
        let tf = TextFlowView(frame: CGRect(x:0,y:0,width:320,height:40), text: text)
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.clearColor()
        tf.tintColor = UIColor.whiteColor()
        superview.addSubview(tf)
        
        let topConstraint = NSLayoutConstraint(item:tf,
            attribute:.Bottom,
            relatedBy:.Equal,
            toItem:superview,
            attribute:.Bottom,
            multiplier:1.0,
            constant:-50.0
        )
        superview.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item:tf,
            attribute:.Leading,
            relatedBy:.Equal,
            toItem:superview,
            attribute:.Leading,
            multiplier:1.0,
            constant:0.0
        )
        superview.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item:tf,
            attribute:.Trailing,
            relatedBy:.Equal,
            toItem:superview,
            attribute:.Trailing,
            multiplier:1.0,
            constant:0.0
        )
        superview.addConstraint(rightConstraint)
        
        let heightConstraint = NSLayoutConstraint(item:tf,
            attribute:.Height,
            relatedBy:.Equal,
            toItem:nil,
            attribute:.NotAnAttribute,
            multiplier:1.0,
            constant:40.0
        )
        superview.addConstraint(heightConstraint)
    }
}
