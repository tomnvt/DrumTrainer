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
        print("Blinking")
        metronomeButtonSubView.blink()
    }
    
    
    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    var metronomeButtonSubView = UIView()

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
        
        metronomeButtonSubView.backgroundColor = .yellow
        metronomeButton.addSubview(metronomeButtonSubView)
        metronomeButtonSubView.frame.equalTo(metronomeButton.frame)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.backgroundColor = UIColor.white
        drums.play(note_tag: sender.tag)
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

extension UIView{
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}
