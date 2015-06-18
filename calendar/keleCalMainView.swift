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
    
    private var _topLabel:UILabel?
    
    private var _data:KeleData = KeleData()
    
    private let _scrollView: UIScrollView!
    
    
    private var _page:Int!
    private var _pageChanged:Bool =  false
    private var _lastContentOffset:CGFloat = 0
    private var _direction: ScrollDirection = .None


    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        
        
        _scrollView = UIScrollView(frame:frame)
        
        // Setup Scroll View.
        _scrollView.contentSize = CGSizeMake(frame.width * 3, frame.height)
        _scrollView.showsHorizontalScrollIndicator = false
        _scrollView.frame = frame
        _scrollView.pagingEnabled = true
        _scrollView.delegate = self
        
        addSubview(_scrollView)
        
        self.initUI(frame)

    }
    
    private func initUI(frame:CGRect)
    {
        let container:UIView = UIView(frame:frame)
        
        
        let bounds = UIScreen.mainScreen().bounds
        
        _topLabel = UILabel(frame: CGRectMake(0, 0, bounds.width, 30))
        _topLabel?.text = _data.getDayStr()
        
        _topLabel?.textColor = UIColor.redColor()
        _topLabel?.textAlignment = NSTextAlignment.Center

        addSubview(_topLabel!)
        
        let data = _data.data
        var index = 1
        let size = 100
        for i in 0...5 {
            for j in 0...6{
                
               let item = KeleCalCellView(frame: CGRectMake((CGFloat(j * size)), (CGFloat(i * size)), CGFloat(size), CGFloat(size)) )
                
                container.addSubview(item)
                
                if (index < data.startWeek! || index > data.startWeek! + data.totalDays! - 1)
                {
                    item.setDay(0, today: false)
                } else {
                    let dayIndex = index - data.startWeek! + 1
                    
                    if data.today == dayIndex {
                        item.setDay(dayIndex, today: true)
                    } else {
                        item.setDay(dayIndex, today: false)
                    }
                    
                }
                
                index++
            }
        }
        
        
        _scrollView.addSubview(container)

    }
    
    // MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        let width = scrollView.frame.width
        
        let page = Int(floor((_scrollView.contentOffset.x - width/2) / width) + 1)
        if page !=  _page {
            _page = page
            
            _pageChanged = !_pageChanged
            
            if !_pageChanged {
                _pageChanged = true
            } else {
                _pageChanged = false
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
        
        println( _lastContentOffset)

    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    }

    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
