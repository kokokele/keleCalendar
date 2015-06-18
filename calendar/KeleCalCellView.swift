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
    
    
    var _day:Int?
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        
        _button = UIButton.buttonWithType(UIButtonType.Custom)as? UIButton
        _button!.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        _button!.backgroundColor = UIColor.clearColor()
        _button!.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(_button!)
        
        _dayLabel = UILabel(frame: self.bounds)
        _dayLabel!.textAlignment = NSTextAlignment.Center
        _dayLabel!.font = UIFont(name: "HelveticaNeue-Light" , size: 18.0);
        _dayLabel!.backgroundColor = UIColor.clearColor()
        addSubview(_dayLabel!)
    }
    
    
    func setDay(day:Int, today:Bool){
        
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
