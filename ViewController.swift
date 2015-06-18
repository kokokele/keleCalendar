//
//  ViewController.swift
//  KeleCalendar
//
//  Created by antz on 15/6/17.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    var kele:KeleCalMainView!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var preBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //println(cd.monthDateRange(NSDate()))
        
        kele = KeleCalMainView(frame: CGRectMake(0, 50, 310, 200))
        
        view.addSubview(kele)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNextPressed(sender: AnyObject) {
        
    }
    @IBAction func onPrePressed(sender: AnyObject) {
        
    }

}

