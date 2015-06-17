//
//  keleData.swift
//  KeleCalendar
//
//  Created by antz on 15/6/17.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

private var INS:KeleData?


struct CalData {
    var startWeek:Int?
    var totalDays:Int?
    var today:Int? //如果>1 表示当月即今月
    var year:Int?
    var month:Int?
    
    init(){
        
    }
}

class KeleData:NSObject
{
    private var _calendar: NSCalendar?
    private var _todayDate:NSDate?
    private var _todayComp:NSDateComponents?
    
    
    private var _currentComp:NSDateComponents?
    
    
    var data:CalData = CalData()
    
    class func getIns()->KeleData
    {
        if (INS == nil)
        {
            INS = KeleData()
        }
        
        return INS!
    }
    
    override init()
    {
        super.init()
        self._calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        self._calendar!.firstWeekday = 1
        
        self.setToday()
        
    }
    
    internal func next()
    {
        _currentComp?.month++
        
        parse(getDateByComp(_currentComp!))
    }
    
    internal func pre()
    {
        _currentComp?.month--
        parse(getDateByComp(_currentComp!))

    }
    
    private func getDateByComp(comp:NSDateComponents)->NSDate
    {
        let date:NSDate! = self._calendar?.dateFromComponents(comp)
        
        return date
    }
    
    
    internal func setToday()
    {
        _todayDate = NSDate()
        _todayComp = dateRange(_todayDate!)
        
        parse(_todayDate!)
    }

    //-------------------PRIVATE---------------------------------
    private func parse(date:NSDate)
    {
        //当前月和年
        let comp:NSDateComponents = self.dateRange(date)
        data.year = comp.year
        data.month = comp.month
        
        _currentComp = comp
        
        //当月第一天开始week
        comp.day = 1
        let date:NSDate! = self._calendar?.dateFromComponents(comp)
        let comp1 = self.dateRange(date)
        data.startWeek =  comp1.weekday
        
        //当月总天数
        let total:Int! = self._calendar?.rangeOfUnit(NSCalendarUnit.DayCalendarUnit, inUnit: NSCalendarUnit.MonthCalendarUnit, forDate: date).length
        data.totalDays = total
        
        //当月是否有今日
        if(data.year == _todayComp?.year && data.month == _todayComp?.month)
        {
            data.today = _todayComp?.day
        } else {
            data.today = -1
        }
        
        
        println(data.year)
        println(data.month)
        println(data.today)
        println(data.totalDays)
        println(data.startWeek)
        println("-------------")
        
    }
    
    private func dateRange(date: NSDate) -> (NSDateComponents) {
        
        let units = NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.WeekCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.CalendarUnitWeekday
        let components = self._calendar?.components(units, fromDate: date)
        
        
        return components!
    }
    
    
    //    internal func monthDateRange(date: NSDate) -> (countOfWeeks: NSInteger, monthStartDate: NSDate, monthEndDate: NSDate) {
    //
    //        var components = self.dateRange(date)
    //        // Start of the month.
    //        components.day = 1
    //        let monthStartDate = self._calendar?.dateFromComponents(components)
    //
    //        // End of the month.
    //        components.month += 1
    //        components.day -= 1
    //        let monthEndDate = self._calendar?.dateFromComponents(components)
    //
    //        // Range of the month.
    //        let range = self._calendar?.rangeOfUnit(NSCalendarUnit.WeekCalendarUnit, inUnit: NSCalendarUnit.MonthCalendarUnit, forDate: date)
    //        let countOfWeeks = range?.length
    //
    //        return (countOfWeeks!, monthStartDate!, monthEndDate!)
    //        
    //    }
    
    
    
}


