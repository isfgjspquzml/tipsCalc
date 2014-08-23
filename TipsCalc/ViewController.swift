//
//  ViewController.swift
//  TipsCalc
//
//  Created by Tianyu Shi on 8/20/14.
//  Copyright (c) 2014 tianyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var instructionBackground: UIView!
    @IBOutlet weak var tipControlBackground: UIView!
    @IBOutlet weak var billBackground: UIView!
    @IBOutlet weak var tipAmountBackground: UIView!
    @IBOutlet weak var taxAmountBackgroudn: UIView!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalBackground: UIView!
    
    let INITIAL_VALUE = "$0.00"
    let TIME = "time"
    let BILL_AMOUNT = "bill_amount"
    let TIP_SELECTED = "tip_selected"
    
    var taxPercentage = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Recording the time
        var defaults = NSUserDefaults.standardUserDefaults()
        var currTime = UInt8(NSDate.timeIntervalSinceReferenceDate())
        var strCurrTime = String(currTime);
        println("Current Time: " + strCurrTime)
        
        // Recording the bill amount
        var billAmount = billField.text
        println("Bill Amount: " + billAmount)
        
        // Recording the tip segment selected
        var tipSelected = String(tipControl.selectedSegmentIndex);
        println("Tip Segment Selected: " + tipSelected)
        
        // Save data
        defaults.setObject(TIME, forKey: strCurrTime)
        defaults.setObject(BILL_AMOUNT, forKey: billAmount)
        defaults.setObject(TIP_SELECTED, forKey: tipSelected)

        defaults.synchronize()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.15, 0.2, 0.25]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = (billField.text as NSString).doubleValue
        var tipPercent = tipPercentage
        var tipAmount = billAmount * tipPercent
        var totalAmount = tipAmount + billAmount
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }

    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

