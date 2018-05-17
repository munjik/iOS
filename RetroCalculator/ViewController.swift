//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Munji on 5/13/18.
//  Copyright © 2018 Munji. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var outputLbl: UILabel!
    // variable for the btnSound linked with AVAudio Player
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case add = "+"
        case Empty = "Empty"
    }
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav" )
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
        
        
    }
    // each IBAction func is linked to each button on the calculator. As we simply tap the numbers then the noise will play
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        //Basically takes the numbers and puts them togther.. 23452
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
        //outlets for the action pressed...
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: Operation.Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: Operation.Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: Operation.add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    
    
    //simple function playing the sound, we automatically stop the sound.
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            //A user selected an operator, but then selected another operation without first entering a number
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                leftValString = result
                outputLbl.text = result
            }
            currentOperation = operation
        } else {
            //this is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

