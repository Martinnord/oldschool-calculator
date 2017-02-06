//
//  ViewController.swift
//  Calculator
//
//  Created by Martin Nordström on 2017-01-30.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "btn", ofType: "wav") // Bundle: Stores the paths in our application. Now I'm getting the path for the sound effect
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)" // Appends the number to the runningNumber with the numbers tag.
        outputLbl.text = runningNumber
    }

    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            // This is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
    }
    
    
}

