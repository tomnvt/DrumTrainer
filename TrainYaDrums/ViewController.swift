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
        metronomeButton.orangeBlink()
    }
    
    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    let drums = Drums()
    let metronome = Metronome()
    let examplePlayer = ExamplePlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drums.loadDrums()
        
        AudioKit.output = drums.drums
        
        do {
            try AudioKit.start()
        } catch {
            print("Error while starting AudioKit.")
        }
        
        bpmSlider.setValue(Float(defaults.integer(forKey: "bpmValue")), animated: false)
        
        metronome.delegate = self
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        drums.play(note_tag: sender.tag)
        sender.yellowBlink()
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
        bpmValueLabel.text = String(Int(sender.value))
        defaults.set(Int(sender.value), forKey: "bpmValue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                self.bpmValueLabel.text = "BPM"
        }
    }
    
    @IBAction func exampleButtonPressed(_ sender: UIButton) {
        examplePlayer.playExample()
    }
    
}

@IBDesignable
class RoundableView: UIView {}
class RoundableStackView: UIStackView {}
class RoundableButton: UIButton {}
