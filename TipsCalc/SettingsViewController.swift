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
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var lightDarkSwitch: UISwitch!
    @IBOutlet weak var light: UILabel!
    @IBOutlet weak var dark: UILabel!
    
    @IBOutlet weak var lightDarkView: UIView!
    @IBOutlet weak var instructionsSetTip: UILabel!
    @IBOutlet weak var percentSign: UILabel!
    @IBOutlet weak var instructionsTapPlus: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    
    var tipSegment = -1
    
    // Do class properties exist? Just getting stuff to work
    let TIP_SEGMENT_ONE = "tipSegOne"
    let TIP_SEGMENT_TWO = "tipSegTwo"
    let TIP_SEGMENT_THREE = "tipSegThree"
    let TIME = "time"
    let THEME = "theme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var defaults = NSUserDefaults.standardUserDefaults()
        var light = defaults.objectForKey(THEME) as Bool?
        if(light == nil) {
            light = false
        } else {
            lightDarkSwitch.on = light!
        }
        
        updateTheme()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func updateTheme() {
        if(!lightDarkSwitch.on) {
            var lightBlue: UIColor = UIColor(red: CGFloat(0.81), green: CGFloat(0.96), blue: CGFloat(0.99), alpha: CGFloat(1.0))
            var lightPurple: UIColor = UIColor(red: CGFloat(0.90), green: CGFloat(0.82), blue: CGFloat(1.00), alpha: CGFloat(1.0))


            lightDarkView.backgroundColor = UIColor.whiteColor()
            topView.backgroundColor = lightBlue
            bottomView.backgroundColor = lightPurple
            
            light.textColor = UIColor.grayColor()
            dark.textColor = UIColor.darkGrayColor()
            instructionsSetTip.textColor = UIColor.darkGrayColor()
            instructionsTapPlus.textColor = UIColor.grayColor()
            percentSign.textColor = UIColor.darkGrayColor()
            returnButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        } else {
            var darkBlue: UIColor = UIColor(red: CGFloat(0.03), green: CGFloat(0.00), blue: CGFloat(0.58), alpha: CGFloat(1.0))
            var darkPurple: UIColor = UIColor(red: CGFloat(0.40), green: CGFloat(0.00), blue: CGFloat(0.58), alpha: CGFloat(1.0))
            
            lightDarkView.backgroundColor = UIColor.blackColor()
            topView.backgroundColor = darkBlue
            bottomView.backgroundColor = darkPurple
            
            light.textColor = UIColor.whiteColor()
            dark.textColor = UIColor.lightTextColor()
            instructionsSetTip.textColor = UIColor.lightTextColor()
            instructionsTapPlus.textColor = UIColor.grayColor()
            percentSign.textColor = UIColor.lightTextColor()
            returnButton.setTitleColor(UIColor.cyanColor(), forState: .Normal)
        }
    }
    
    @IBAction func onTapTip(sender: AnyObject) {
        if(tipSegment == -1) {
            return
        }
        
        // Save data
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipInit = (tipPercentInput.text as NSString).doubleValue
        
        // Would find a way to get other class but for now just getting stuff working
        switch tipSegment {
        case 0:
            defaults.setObject(tipInit, forKey: TIP_SEGMENT_ONE)
        case 1:
            defaults.setObject(tipInit, forKey: TIP_SEGMENT_TWO)
        case 2:
            defaults.setObject(tipInit, forKey: TIP_SEGMENT_THREE)
        default:
            return
        }
        
        tipPercentInput.text = ""
    }
    
    @IBAction func onValueChangedTipControl(sender: AnyObject) {
        tipSegment = tipControl.selectedSegmentIndex
    }
    
    @IBAction func onTapReturn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onValueChangedSwitch(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(lightDarkSwitch.on, forKey: THEME)
        updateTheme()
    }
    
    @IBAction func onViewTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
