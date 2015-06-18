//
//  KeleCalCellView.swift
//  KeleCalendar
//
//  Created by antz on 15/6/17.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

class KeleCalCellView: UIView
{
    var _button:UIButton?
    var _dayLabel:UILabel?
    
    var _marker:KeleDraw!
    
    private var _isToday:Bool = false

    
    var _day:Int?
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        
        
        _dayLabel = UILabel(frame: self.bounds)
        _dayLabel!.textAlignment = NSTextAlignment.Center
        _dayLabel!.font = UIFont(name: "HelveticaNeue-Light" , size: 18.0);
        _dayLabel!.backgroundColor = UIColor.clearColor()
        addSubview(_dayLabel!)
        
        
        _marker = KeleDraw(frame:self.bounds, color: UIColor.grayColor(), _alpha: 1)
//        _marker.center = CGPointMake(x, y)
        
        self.insertSubview(_marker, atIndex: 0)
        
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "dayViewTapped")
        
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func dayViewTapped()
    {
        println(String(_day!))

    }
    
    
    func setDay(day:Int, today:Bool){
        
        _isToday = today
        
        _day = day
                
        if day == 0 {
            _dayLabel!.text = "";
        } else {
            _dayLabel!.text = String(day)
        }
        
        
        if today {
            
            _dayLabel!.textColor = UIColor.orangeColor()
            self.userInteractionEnabled = true
        }else{
            _dayLabel!.textColor = UIColor.blackColor()
        }
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction(sender: UIButton)
    {
        println(String(_day!))
    }
}
