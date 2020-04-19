//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Shane Richards on 4/18/20.
//  Copyright © 2020 Shane Richards. All rights reserved.
//

import UIKit

class PlaySounsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordAudioURL: URL!
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        
    }
}
