//
//  ViewController.swift
//  TipsCalc
//
//  Created by Tianyu Shi on 8/20/14.
//  Copyright (c) 2014 tianyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var instructionBackground: UIView!
    @IBOutlet weak var tipControlBackground: UIView!
    @IBOutlet weak var billBackground: UIView!
    @IBOutlet weak var tipBackground: UIView!
    @IBOutlet weak var totalBackground: UIView!
    
    @IBOutlet weak var tipInstructionLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Strings for stored session values
    let INITIAL_VALUE = "0.00"
    let BILL_AMOUNT = "bill_amount"
    let TIP_SELECTED = "tip_selected"
    
    // Strings for stored permanent values
    let TIP_SEGMENT_ONE = "tipSegOne"
    let TIP_SEGMENT_TWO = "tipSegTwo"
    let TIP_SEGMENT_THREE = "tipSegThree"
    let TIME = "time"
    let THEME = "theme"
    
    // Other constants
    let SAVE_TIME = 600 // 10 minutes
    
    // Initial Values
    var firstLoad = true
    var instructionsRemoved = false;
    var tipPercentages = [0.15, 0.18, 0.20]
    var tipSegmentSelected = 1;
    var taxPercentage = 0.1
    var currTheme = false
    var localCurrency = "$"
    
    func calculateBill() {
        if(tipControl.selectedSegmentIndex == -1) {
            return
        }
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var billAmount = (billField.text as NSString).doubleValue
        var tipAmount = billAmount * tipPercentage
        var totalAmount = billAmount + tipAmount
        tipLabel.text = localCurrency + String(format: "%.2f", tipAmount)
        totalLabel.text = localCurrency + String(format: "%.2f", totalAmount)
    }
    
    func updateSetting(setting:String) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tip = defaults.objectForKey(setting) as Double?
        
        switch(setting) {
        case TIP_SEGMENT_ONE:
            if(tip != nil) {
                tipPercentages[0] = tip!/100
                tipControl.setTitle(NSString(format: "%.0f", tip!) + "%", forSegmentAtIndex: 0)
            } else {
                tipControl.setTitle("15%", forSegmentAtIndex: 0)
            }
        case TIP_SEGMENT_TWO:
            if(tip != nil) {
                tipPercentages[1] = tip!/100
                tipControl.setTitle(NSString(format: "%.0f", tip!) + "%", forSegmentAtIndex: 1)
            } else {
                tipControl.setTitle("18%", forSegmentAtIndex: 0)
            }
        case TIP_SEGMENT_THREE:
            if(tip != nil) {
                tipPercentages[2] = tip!/100
                tipControl.setTitle(NSString(format: "%.0f", tip!) + "%", forSegmentAtIndex: 2)
            } else {
                tipControl.setTitle("20%", forSegmentAtIndex: 0)
            }
        default:
            return
        }
    }
    
    func updateTheme() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var theme = defaults.objectForKey(THEME) as Bool?
        if(theme != nil) {
            if (theme == currTheme) {
                return
            }
        } else {
            theme = false
        }
        
        currTheme = theme!
        
        if(!currTheme) {
            tipControlBackground.backgroundColor = UIColor.whiteColor()
            billBackground.backgroundColor = UIColor.greenColor()
            tipBackground.backgroundColor = UIColor.magentaColor()
            totalBackground.backgroundColor = UIColor.whiteColor()
            totalLabel.textColor = UIColor.blackColor()
            totalTextLabel.textColor = UIColor.blackColor()
            tipControl.tintColor = UIColor.blueColor()

        } else {
            tipControlBackground.backgroundColor = UIColor.grayColor()
            billBackground.backgroundColor = UIColor.greenColor()
            tipBackground.backgroundColor = UIColor.magentaColor()
            totalBackground.backgroundColor = UIColor.grayColor()
            totalLabel.textColor = UIColor.whiteColor()
            totalTextLabel.textColor = UIColor.whiteColor()
            tipControl.tintColor = UIColor.blueColor()
        }
    }
    
    override func viewDidLoad() {
        if(!firstLoad) {
            return
        }
        
        var currentLocale = NSLocale.currentLocale()
        localCurrency = currentLocale.objectForKey(NSLocaleCurrencySymbol) as String!
        
        // Stored settings variables
        updateSetting(TIP_SEGMENT_ONE)
        updateSetting(TIP_SEGMENT_TWO)
        updateSetting(TIP_SEGMENT_THREE)
        
        firstLoad = true
        
        // Previous session variables
        var defaults = NSUserDefaults.standardUserDefaults()
        var lastSessionTime = defaults.objectForKey(TIME) as Int?
        
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
        totalLabel.text = INITIAL_VALUE
        tipControl.selectedSegmentIndex = -1
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Stored settings variables
        updateSetting(TIP_SEGMENT_ONE)
        updateSetting(TIP_SEGMENT_TWO)
        updateSetting(TIP_SEGMENT_THREE)
        updateTheme()
        
        instructionsRemoved = false
        calculateBill()
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
    
    @IBAction func onTipChanged(sender: AnyObject) {
        if(!instructionsRemoved) {
            var instructionHeight = instructionBackground.frame.size.height
            UIView.animateWithDuration(1, delay:0.25, options: .CurveEaseOut, animations: {
                var viewParentTopFrame = self.viewParent.frame
                viewParentTopFrame.origin.y -= instructionHeight
                
                self.viewParent.frame = viewParentTopFrame
                }, completion: { finished in
                    self.instructionsRemoved = true
            })
        }
        calculateBill()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateBill()
    }
    
    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

