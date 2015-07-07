//
//  keleDraw.swift
//  KeleCalendar
//
//  Created by antz on 15/6/18.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

class KeleDraw: UIView {
    
    private let color: UIColor?
    
    init(frame: CGRect, color: UIColor, _alpha: CGFloat) {
        
        self.color = color
        super.init(frame: frame)
        self.alpha = _alpha

        
        
        
        self.backgroundColor = .clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        
        
        var context = UIGraphicsGetCurrentContext()

        
        /*画矩形*/
        CGContextStrokeRect(context,CGRectMake(1, 0, frame.width, frame.height));//画方框
        //CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
        //矩形，并填弃颜色
        CGContextSetLineWidth(context, 1.0);//线的宽度
        
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor);//填充颜色
        CGContextSetStrokeColorWithColor(context, UIColor.yellowColor().CGColor);//线框颜色
        CGContextAddRect(context,CGRectMake(1, 0, frame.width, frame.height));//画方框
        CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
        
        return
//        
//        CGContextSetLineWidth(context, 2)
//        
//        var radius = (frame.width > frame.height) ? frame.height : frame.width
//        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (radius - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
//        
//        // Draw
//        CGContextSetFillColorWithColor(context, self.color!.CGColor)
//        CGContextSetStrokeColorWithColor(context, self.color!.CGColor)
//        CGContextDrawPath(context, kCGPathFillStroke)
    }
    
    
}