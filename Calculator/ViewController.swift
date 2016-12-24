//
//  ViewController.swift
//  Calculator
//
//  Created by Xuezhu on 12/23/16.
//  Copyright © 2016 Xuezhu. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            if digit != "0" {
                userIsInTheMiddleOfTyping = true
            }
            if digit == "." {
                display.text = "0" + digit
            }
            else {
                display.text = digit
            }
        }
        
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(format:"%g", newValue)
        }
    }
    
    var savedProgram: Model.PropertyList?
    @IBAction func save() {
        savedProgram = model.program
    }
    
    @IBAction func ans() {
        if savedProgram != nil {
            model.program = savedProgram!
            displayValue = model.result
        }
    }
    
    private var model = Model()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            model.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            model.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = model.result
    }
}

