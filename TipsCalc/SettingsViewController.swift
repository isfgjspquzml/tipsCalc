//
//  SettingsViewController.swift
//  TipsCalc
//
//  Created by Tianyu Shi on 8/21/14.
//  Copyright (c) 2014 tianyu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipPercentInput: UITextField!
    @IBOutlet weak var taxPercentInput: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lightDarkSwitch: UISwitch!
    @IBOutlet weak var light: UILabel!
    @IBOutlet weak var dark: UILabel!
    @IBOutlet weak var lightDarkView: UIView!
    @IBOutlet weak var instructions1: UILabel!
    @IBOutlet weak var percent1: UILabel!
    @IBOutlet weak var tapInstructions1: UILabel!
    @IBOutlet weak var instructions2: UILabel!
    @IBOutlet weak var percent2: UILabel!
    @IBOutlet weak var tapInstructions2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    @IBAction func onTapTip(sender: AnyObject) {
    }

    @IBAction func onTapTax(sender: AnyObject) {
    }
    
    @IBAction func onValueChangedTipControl(sender: AnyObject) {
    }
    
    @IBAction func onTapReturn(sender: AnyObject) {
    }
    
    @IBAction func onValueChangedSwitch(sender: AnyObject) {
    }
    
    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
