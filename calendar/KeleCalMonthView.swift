//
//  KeleCalMonthView.swift
//  KeleCalendar
//
//  Created by antz on 15/6/18.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit


class KeleCalMonthView:UIView{
    
    
    
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        
        
        self.backgroundColor = UIColor.brownColor()

    }
    
    
    
    func render(data:CalData)
    {
        var index = 1
        //每个框大小
        let size = 40
        
        for i in 0...5 {
            for j in 0...6{
                
                var item:KeleCalCellView? =  self.viewWithTag(index) as? KeleCalCellView
                
                if item == nil {
                    
                    item = KeleCalCellView(frame: CGRectMake((CGFloat(j * size)), (CGFloat(i * size)), CGFloat(size), CGFloat(size)) )
                    item!.tag = index
                    self.addSubview(item!)

                }
                
                if (index < data.startWeek! || index > data.startWeek! + data.totalDays! - 1)
                {
                    item!.setDay(0, today: false)
                    
                } else {
                    
                    let dayIndex = index - data.startWeek! + 1
                    
                    if data.today == dayIndex {
                        item!.setDay(dayIndex, today: true)
                    } else {
                        item!.setDay(dayIndex, today: false)
                    }
                    
                }
                
                index++
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
