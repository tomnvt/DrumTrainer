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
    }
    
}

