//
//  ViewController.swift
//  KeleCalendar
//
//  Created by antz on 15/6/17.
//  Copyright (c) 2015年 antz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var cd:KeleData = KeleData()
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var preBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //println(cd.monthDateRange(NSDate()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNextPressed(sender: AnyObject) {
        cd.next()
        
    }
    @IBAction func onPrePressed(sender: AnyObject) {
        
        cd.pre()
    }

}

