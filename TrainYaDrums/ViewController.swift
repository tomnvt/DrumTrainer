//
//  ViewController.swift
//  TrainYaDrums
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    
    let defaults = UserDefaults.standard
    
    let drums = Drums()
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        drums.play(note_tag: sender.tag)
    }
    
    @IBAction func clickButtonPressed(_ sender: UIButton) {
        print("Click sound will start or stop playing")
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        bpmValueLabel.text = String(Int(sender.value)) + " BPM"
        defaults.set(Int(sender.value), forKey: "bpmValue")
    }
    
}

