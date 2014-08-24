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
    
    
    // Strings for stored session values
    let INITIAL_VALUE = "$0.00"
    let BILL_AMOUNT = "bill_amount"
    let TIP_SELECTED = "tip_selected"
    
    // Strings for stored permanent values
    let TIP_SEGMENT_ONE = "tipSegOne"
    let TIP_SEGMENT_TWO = "tipSegTwo"
    let TIP_SEGMENT_THREE = "tipSegThree"
    let TAX = "tax"
    let TIME = "time"
    
    // Other constants
    let SAVE_TIME = 600 // 10 minutes
    
    // Initial Values
    var firstLoad = true
    var tipPercentages = [0.15, 0.2, 0.25]
    var tipSegmentSelected = 1;
    var taxPercentage = 0.1
    
    func calculateBill() {
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = (billField.text as NSString).doubleValue
        var tipAmount = billAmount * taxPercentage
        var totalAmount = tipAmount + billAmount
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    func updateSetting(setting:String) {
        var defaults = NSUserDefaults.standardUserDefaults()
        switch(setting) {
        case TIP_SEGMENT_ONE:
            var tip = defaults.objectForKey(setting) as Double?
            if(tip != nil) {
                tipPercentages[0] = tip!
                tipControl.setTitle(NSString(format: "%.2f", tipPercentages[0]) + "%", forSegmentAtIndex: 0)
            }
        case TIP_SEGMENT_TWO:
            var tip = defaults.objectForKey(setting) as Double?
            if(tip != nil) {
            tipPercentages[1] = defaults.objectForKey(setting) as Double!
            tipControl.setTitle(NSString(format: "%.2f", tipPercentages[1]) + "%", forSegmentAtIndex: 1)
            }
        case TIP_SEGMENT_THREE:
            var tip = defaults.objectForKey(setting) as Double?
            if(tip != nil) {
            tipPercentages[2] = defaults.objectForKey(setting) as Double!
            tipControl.setTitle(NSString(format: "%.2f", tipPercentages[2]) + "%", forSegmentAtIndex: 2)
            }
        case TAX:
            var tip = defaults.objectForKey(setting) as Double?
            if(tip != nil) {
            taxPercentage = defaults.objectForKey(setting) as Double!
            }
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        if(!firstLoad) {
            return
        }
        
        firstLoad = true
        
        // Previous session variables
        var defaults = NSUserDefaults.standardUserDefaults()
        var lastSessionTime = defaults.objectForKey(TIME) as Int?
        var taxPercentage = defaults.objectForKey(TAX) as Double?
        
        // Stored settings variables
        updateSetting(TIP_SEGMENT_ONE)
        updateSetting(TIP_SEGMENT_TWO)
        updateSetting(TIP_SEGMENT_THREE)
        updateSetting(TAX)
        
        if(lastSessionTime !=  nil) {
            var currTime = Int(NSDate.timeIntervalSinceReferenceDate())
            var diff = currTime - lastSessionTime!
            
            if(diff < SAVE_TIME) {
                tipControl.selectedSegmentIndex = defaults.objectForKey(TIP_SELECTED) as Int!
                billField.text = defaults.objectForKey(BILL_AMOUNT) as String!
                calculateBill()
                return
            }
        }
        
        tipLabel.text = INITIAL_VALUE
        taxLabel.text = INITIAL_VALUE
        totalLabel.text = INITIAL_VALUE
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Recording the time
        var currTime = Int(NSDate.timeIntervalSinceReferenceDate())
        
        // Recording the bill amount
        var billAmount = billField.text
        println("Bill Amount: " + billAmount)
        
        // Recording the tip segment selected
        var tipSelected = tipControl.selectedSegmentIndex;
        println("Tip Segment Selected: " + String(tipSelected))
        
        // Save data
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(currTime, forKey: TIME)
        defaults.setObject(billAmount, forKey: BILL_AMOUNT)
        defaults.setObject(tipSelected, forKey: TIP_SELECTED)
        defaults.synchronize()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateBill()
    }
    
    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

