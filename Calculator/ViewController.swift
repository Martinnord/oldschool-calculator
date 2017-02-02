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

    var btnSound = AVAudioPlayer
    
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



}

