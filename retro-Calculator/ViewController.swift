//
//  ViewController.swift
//  retro-Calculator
//
//  Created by Ashwini Tangade on 2/11/16.
//  Copyright © 2016 wipro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation :String{
        case divide = "/"
        case multiply = "*"
        case add = "+"
        case subtract = "-"
        case empty = "empty"
    }
    @IBOutlet weak var resultText: UILabel!
    var btnSound : AVAudioPlayer!
    
    var leftValString = ""
    var rightValString = ""
    var runningNumber = ""
    var currentOperation : Operation = Operation.empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("button", ofType: "wav")
        let soundUrl = NSURL.fileURLWithPath(path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
        
    }
    @IBAction func numberPressed(sender: UIButton)
    {
        runningNumber += "\(sender.tag)"
        resultText.text=runningNumber
        playSound()
    }
    @IBAction func dotPressed(sender: UIButton)
    {
        runningNumber += "."
        resultText.text=runningNumber
        playSound()
    }
    @IBAction func multiply(sender: UIButton)
    {
        processOperation(Operation.multiply)
        
    }
    @IBAction func divide(sender: UIButton)
    {
        processOperation(Operation.divide)

    }
    @IBAction func add(sender: UIButton)
    {
        processOperation(Operation.add)

    }
    @IBAction func subtract(sender: UIButton)
    {
        processOperation(Operation.subtract)

    }
    @IBAction func calculate(sender: UIButton)
    {
        processOperation(currentOperation)
    }
    func processOperation(op:Operation)
    {
        playSound()
        if(currentOperation != Operation.empty)
        {
            //Run some math
            
            //A user selected an operator, but then selected another operator without
            //first entering a number
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                resultText.text = result
            }
            
            
            currentOperation = op
            
        } else {
            //This is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    func playSound()
    {
        if(btnSound.playing)
        {
            btnSound.stop()
        }
        btnSound.play()
    }
}
