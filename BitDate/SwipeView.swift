//
//  SwipeView.swift
//  BitDate
//
//  Created by User  on 2015-08-21.
//  Copyright (c) 2015 Wub.com. All rights reserved.
//

import Foundation
import UIKit
class SwipeView: UIView {
    
    enum Direction {
        case None
        case Left
        case Right
    }
    
    weak var delegate: SwipeViewDelegate?
    
    //private let card: CardView = CardView()
    var innerView: UIView? {
        didSet {
            if let v = innerView {
                addSubview(v)
                v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            }
        }
    }
    private var originalPoint: CGPoint?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    init() {
        super.init(frame: CGRectZero)
        initialize()
    }
    private func initialize() {
        //change it back to clearcolor
        self.backgroundColor = UIColor.redColor()
        //addSubview(card)
        originalPoint = center
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
        //card.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        //card.setTranslatesAutoresizingMaskIntoConstraints(false)
       
        
    }
    
    func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translationInView(self)
        println("Distance x:\(distance.x) y: \(distance.y)")
        center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
        
        switch gestureRecognizer.state{
        case UIGestureRecognizerState.Began:
            originalPoint = center
        case UIGestureRecognizerState.Changed:
            let rotationPercent = min(distance.x/(self.superview!.frame.width/2), 1)
            let rotationAngle = (CGFloat(2*M_PI/16)*rotationPercent)
            //transform = CGAffineTransformRotate(transform, rotationAngle)
            transform = CGAffineTransformMakeRotation( rotationAngle)
           
            center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
        case UIGestureRecognizerState.Ended:
            
            if abs(distance.x) < frame.width/4 {
                resetViewPositionAndTransformations()
            }
            else {
                swipe(distance.x > 0 ? .Right : .Left)
            }
            
        default:
            println("Default trigged for GestureRecognizer")
            break
        }
    }
    
    func swipe(s: Direction) {
        
        if s == .None {
            return
        }
        var parentWidth = superview!.frame.size.width
        if s == .Left {
            
            parentWidth *= -1
            
        } else if s == .Right {
            
            parentWidth *= 2
            
        }
        
        
        UIView.animateWithDuration(0.2, animations: {
            self.center.x = self.frame.origin.x + parentWidth
            }, completion: {
                // completion expects a boolean, that's what success is doing here, if true we run the next line
                success in
                if let d = self.delegate {
                    s == .Right ? d.swipedRight() : d.swipedLeft()
                }
        })
        
    }
    
    private func resetViewPositionAndTransformations() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0)
            
            //card.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        })
    }
}

protocol SwipeViewDelegate: class {
    func swipedLeft()
    func swipedRight()
}
