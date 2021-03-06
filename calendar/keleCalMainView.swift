//
//  keleCalMainView.swift
//  KeleCalendar
//
//  Created by antz on 15/6/17.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case None
    case Right
    case Left
}

class KeleCalMainView: UIView, UIScrollViewDelegate {
    
    
    var delegate:KeleCalDelegate?
    
    
    private var _topLabel:UILabel?
    
    private var _keleData:KeleCalData = KeleCalData()
    
    private let _scrollView: UIScrollView!
    
    private let _frame:CGRect!
    
    
    private var _page:Int = 1
    private var _pageChanged:Bool =  false
    private var _lastContentOffset:CGFloat = 0
    private var _direction: ScrollDirection = .None
    
    private var _viewCache = [Int:KeleCalMonthView]()

    
    
     init() {
        
        var frame = CGRectMake(0, 30, 320, 8 * 320 / 7)
        
        
        _frame = frame
        _scrollView = UIScrollView(frame:frame)
        super.init(frame:frame)

        // Setup Scroll View.
        _scrollView.contentSize = CGSizeMake(frame.width * 3, frame.height)
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.frame = CGRectMake(0, 60, frame.width, frame.height)
        _scrollView.pagingEnabled = true
        _scrollView.delegate = self
        

        
        addSubview(_scrollView)
        

        
        

    }
    
    func render()
    {
        self.initUI(_frame)
    }
    
    
    internal func next()
    {
        _pageChanged = true
        _direction = .Left
        
        fit()
    }
    
    internal func pre()
    {
        _pageChanged = true
        _direction = .Right
        fit()
    }
    
    internal func setToday()
    {
        _keleData.setToday()
        
        
        renderMonth()
    }
    
    
    //------------------PRIVATE----------------
    
    private func initUI(frame:CGRect)
    {
        
        let bounds = UIScreen.mainScreen().bounds
        
        //----------------设置标题--------------
        _topLabel = UILabel(frame: CGRectMake(0, 0, bounds.width, 30))
        _topLabel?.text = _keleData.getDayStr(_keleData.currentDay)
        
        _topLabel?.textColor = UIColor.redColor()
        _topLabel?.textAlignment = NSTextAlignment.Center

        addSubview(_topLabel!)
        
        //-------------------日历头----------------
        var  xOffset:CGFloat = self.frame.size.width/7.0;
        var  yOffset:CGFloat = 35.0
        
        var weekLabelArray:[UILabel] = []
        for (var i:Int = 0 ; i<7; i++) {
            var dayOfTheWeekLabel:UILabel = UILabel(frame: CGRectMake(xOffset * CGFloat(i), yOffset, xOffset, 20))
            dayOfTheWeekLabel.textColor = UIColor.blackColor()
            dayOfTheWeekLabel.textAlignment = NSTextAlignment.Center
            dayOfTheWeekLabel.backgroundColor = UIColor.clearColor()
            dayOfTheWeekLabel.highlightedTextColor = UIColor.redColor()
            dayOfTheWeekLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            self.addSubview(dayOfTheWeekLabel)
            weekLabelArray.append(dayOfTheWeekLabel)
        }
        var weekStr = ["日","一","二","三","四","五","六"]
        
        
        for(i, v) in enumerate(weekStr)
        {
            var label:UILabel = weekLabelArray[i] as UILabel
            label.text = v as String
            
            if (i==0 || i == weekStr.count-1) {
                label.textColor = UIColor.orangeColor()
                
            }
        }
        
       
        
        //-------------------weeks------------------
        for i in 0...2 {
            let view = KeleCalMonthView(frame: CGRectMake(frame.width * CGFloat(i), 0, frame.width, frame.height))
            _viewCache[i] = view
            view.tag = i
            view.delegate = delegate
            _scrollView.addSubview(view)
            
            
            if i == 0 {
                
                view.render(_keleData.preDay)
                
            } else if i == 1 {
                
                view.render(_keleData.currentDay)
            } else {
                
                view.render(_keleData.nextDay)
            }
        }
        
        _scrollView.scrollRectToVisible(CGRectMake(frame.width, 0, frame.width, frame.height), animated:false)

    }
    
    
    private func setTitle()
    {
        _topLabel?.text = _keleData.getDayStr(_keleData.currentDay)
    }
    
    // MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        let width = scrollView.frame.width
        
        let page  = Int(floor((_scrollView.contentOffset.x - width/2) / width) + 1)
        
        if page !=  _page {
            
            _page = page
            
            if !self._pageChanged {
                
                self._pageChanged = true
                
            } else {
                
                self._pageChanged = false
            }
        }
        
        
        if _scrollView.contentOffset.y != 0 {
            _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x, 0)
        }
        
        if _lastContentOffset > scrollView.contentOffset.x {
            _direction = .Right
        } else if _lastContentOffset < _scrollView.contentOffset.x {
            _direction = .Left
        }
        
        _lastContentOffset = _scrollView.contentOffset.x
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        fit()
        
        //println("scrollViewDidEndDecelerating:\(_pageChanged)")
        
    }
    
    private func fit()
    {
        if _pageChanged{
            
            var temp:AnyObject!
            
            //----------------调整容器顺序-------------
            if _direction == .Left {
                

                
                _keleData.next()
            } else {
                
                _keleData.pre()
                
            }
            
            
            renderMonth()
            
        } else {
           
            
            
        }
        
        self._pageChanged = false
        self._direction = .None

    }
    
    
    private func renderMonth()
    {
        for i in 0...2 {
            
            //let frame = CGRectMake(_frame.width * CGFloat(i), 0, _frame.width, _frame.height)
            
            let view:KeleCalMonthView! = _viewCache[i]
            //view.frame = frame
            
            
            if i == 0 {
                
                view.render(_keleData.preDay)
                
            } else if i == 1 {
                
                view.render(_keleData.currentDay)
                
            } else {
                
                view.render(_keleData.nextDay)
            }
            
            //println("tag:\(_viewCache[i]?.tag)=\(_frame.width * CGFloat(i))--\(i)")
        }
        
        _scrollView.scrollRectToVisible(CGRectMake(frame.width, 0, frame.width, frame.height), animated:false)
        
        self.setTitle()
    }

    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
