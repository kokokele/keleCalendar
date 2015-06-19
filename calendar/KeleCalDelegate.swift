//
//  KeleCalDelegate.swift
//  KeleCalendar
//
//  Created by antz on 15/6/19.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import Foundation


protocol KeleCalDelegate{
    
    func onCellPressed(cell:KeleCalCellView, kdate:CalDateTimeVO)
    
    func onCellRender(cell:KeleCalCellView,  kdate:CalDateTimeVO)
}
