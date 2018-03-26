//
//  ViewController.swift
//  wilson
//
//  Created by Macintosh on 2017/10/25.
//  Copyright © 2017年 www. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    var isNoFirstRespond = false
    @IBAction func toughtDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isNoFirstRespond{
            
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
            isNoFirstRespond = true
        }
        
    }
    
    var displayValue : Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    private var brain = calculatorBrain()
    @IBAction func toughtSymbol(_ sender: UIButton) {
        if isNoFirstRespond{
            brain.setOperation(displayValue)
            isNoFirstRespond = false
            
        }
        if let mathSymbol = sender.currentTitle {
            brain.perfromOperationg(mathSymbol)
            if mathSymbol == "C" {
                displayValue = 0
                isNoFirstRespond = false
            }
        if let result = brain.returnValue{
            displayValue = result
        }
        
    }
    
}
}
