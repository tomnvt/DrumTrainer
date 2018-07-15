//
//  ViewController.swift
//  TrainYaDrums
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController, MetronomeButtonFlashDelegate {
    
    func metronomeButtonFlash() {
        metronomeButtonSubview.blink()
    }
    
    
    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    @IBOutlet weak var metronomeButtonSubview: UIView!

    let defaults = UserDefaults.standard
    
    let drums = Drums()
    let metronome = Metronome()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drums.loadDrums()
        
        AudioKit.output = drums.drums
        
        do {
            try AudioKit.start()
        } catch {
            print("Error while starting AudioKit.")
        }
        
        bpmValueLabel.text = String(defaults.integer(forKey: "bpmValue")) + " BPM"
        bpmSlider.setValue(Float(defaults.integer(forKey: "bpmValue")), animated: false)
        
        metronome.delegate = self
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.white
        drums.play(note_tag: sender.tag)
        sender.blink()
    }
    
    
    @IBAction func buttonReleased(_ sender: UIButton) {
        sender.backgroundColor = UIColor.yellow
    }
    
    @IBAction func metronomeButtonPressed(_ sender: UIButton) {
        if metronome.metronomeIsRunning {
            metronome.stopMetronome()

        } else {
            metronome.runMetronomeWith(BPM: bpmSlider.value)
        }
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        metronome.changeMetronomeSpeed(toBPM: sender.value)
        bpmValueLabel.text = String(Int(sender.value)) + " BPM"
        defaults.set(Int(sender.value), forKey: "bpmValue")
    }
    
}

@IBDesignable
class RoundableView: UIView {}
class RoundableButton: UIButton {}
