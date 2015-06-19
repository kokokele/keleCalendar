//
//  KeleCalMonthView.swift
//  KeleCalendar
//
//  Created by antz on 15/6/18.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit


class KeleCalMonthView:UIView, KeleCalCellDelegate{
    
    
    var delegate:KeleCalDelegate?
    
    
    private var _cache = [Int:KeleCalCellView]()
    
    private var _lastCell:KeleCalCellView?
    
    private var _data:CalDataVO?
    
    

        
    override init(frame:CGRect)
    {
        super.init(frame: frame)
    }
    
    func cellPressed(cell: KeleCalCellView, day: Int)
    {
        //println("KeleCalMonthView.cellPressed:\(day)")
        _lastCell?.clear()
        
        cell.setSelected()
        
        _lastCell = cell
        
        
        var kdate:CalDateTimeVO = CalDateTimeVO()
        kdate.year = _data?.year
        kdate.month = _data?.month
        kdate.day = day
        
        
        delegate?.onCellPressed(cell, kdate: kdate)
    }
    
    func render(data:CalDataVO)
    {
        _data = data
        
        var index = 1
        //每个框大小
        let size = Int(self.frame.size.width / 7.0)
        
        for i in 0...5 {
            for j in 0...6{
                
                var item:KeleCalCellView?
                
                if  (_cache[index] != nil)
                {
                    
                    item = _cache[index]
                    
                } else {
                    item = KeleCalCellView(frame: CGRectMake((CGFloat(j * size)), (CGFloat(i * size)), CGFloat(size), CGFloat(size)) )
                    item!.tag = index
                    item!.delegate = self
                    self.addSubview(item!)
                    
                    _cache[index] = item

//                    var item1:KeleCalCellView? =  self.viewWithTag(index) as? KeleCalCellView
//                    println("item:\(item1)")
//
//                    if item1 != nil{
//                        println("LLLLLLLLLLLL")
//                    }

                }
                
                var dayIndex:Int = 0
                
                
                if (index < data.startWeek! || index > data.startWeek! + data.totalDays! - 1)
                {
                    item!.setDay(0, today: false)
                    
                } else {
                    
                    dayIndex = index - data.startWeek! + 1
                    
                    if data.today == dayIndex {
                        
                        

                        item!.setDay(dayIndex, today: true)
                    } else {
                        item!.setDay(dayIndex, today: false)
                    }
                    
                }
                
                if dayIndex > 0
                {
                    var kdate:CalDateTimeVO = CalDateTimeVO()
                    kdate.year = _data?.year
                    kdate.month = _data?.month
                    kdate.day = dayIndex
                    
                    
                    delegate?.onCellRender(item!, kdate: kdate)
                }
                
                index++
            }
        }
    }
    

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
