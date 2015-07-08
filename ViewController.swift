//
//  ViewController.swift
//  KeleCalendar
//
//  Created by antz on 15/6/17.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeleCalDelegate {

    
    
    var kele:KeleCalMainView!
    
    
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var preBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //println(cd.monthDateRange(NSDate()))
        
        kele = KeleCalMainView()
        kele.delegate = self
        kele.render()
        self.view.addSubview(self.kele)
        
    }
    
    func onCellRender(cell: KeleCalCellView, kdate: CalDateTimeVO) {
        //println("keleMain.onCellRender:\(kdate.year!)-\(kdate.month!)-\(kdate.day!)")
        
        
        if kdate.month! == 6 && kdate.day! == 11
        {
            var png:UIImageView = UIImageView(image: UIImage(named:"iconfont-yaopin.png")!)
            png.frame = CGRectMake(5, 5, 10, 10)
            cell.addSubview(png)
            
            var png1:UIImageView = UIImageView(image: UIImage(named:"iconfont-naifen.png")!)
            png1.frame = CGRectMake(15, 5, 10, 10)
            cell.addSubview(png1)
            
            
            var png2:UIImageView = UIImageView(image: UIImage(named:"iconfont-zhaoxiangji.png")!)
            png2.frame = CGRectMake(25, 5, 10, 10)
            cell.addSubview(png2)
        }
    }
    
    //---delegate
    func onCellPressed(cell: KeleCalCellView, kdate: CalDateTimeVO) {
        println("keleMain:\(kdate.year!)-\(kdate.month!)-\(kdate.day!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNextPressed(sender: AnyObject) {
        
        kele.next()
        
    }
    @IBAction func onPrePressed(sender: AnyObject) {
        kele.pre()
    }

    @IBAction func onTodayPressed(sender: AnyObject) {
        kele.setToday()
    }
}

