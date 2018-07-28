//
//  ViewController.swift
//  TrainYaDrums
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController, MetronomeButtonFlashDelegate, ExamplePlayerDelegate {
    
    func playDrum(beatpadNumber: [Int]) {
        for drum in beatpadNumber {
            drumPadArray[drum].sendActions(for: .touchDown)
        }
    }
    
    func metronomeButtonFlash() {
        metronomeButton.orangeBlink()
    }
    
    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    @IBOutlet weak var drumPad1: RoundableButton!
    @IBOutlet weak var drumPad2: RoundableButton!
    @IBOutlet weak var drumPad3: RoundableButton!
    @IBOutlet weak var drumPad4: RoundableButton!
    @IBOutlet weak var drumPad5: RoundableButton!
    @IBOutlet weak var drumPad6: RoundableButton!
    @IBOutlet weak var drumPad7: RoundableButton!
    @IBOutlet weak var drumPad8: RoundableButton!
    
    var drumPadArray : Array<RoundableButton> = []
    
    let defaults = UserDefaults.standard
    
    let drums = Drums()
    var metronome : Metronome?
    var examplePlayer: ExamplePlayer?
    let globalClock = GlobalClock()
    
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
        
        metronome?.delegate = self
        examplePlayer = ExamplePlayer()
        examplePlayer?.delegate = self
        
        drumPadArray.append(drumPad1)
        drumPadArray.append(drumPad2)
        drumPadArray.append(drumPad3)
        drumPadArray.append(drumPad4)
        drumPadArray.append(drumPad5)
        drumPadArray.append(drumPad6)
        drumPadArray.append(drumPad7)
        drumPadArray.append(drumPad8)
        
        globalClock.runGlobalCLock()
        metronome = Metronome()
        metronome?.delegate = self
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        drums.play(note_tag: sender.tag)
        sender.yellowBlink()
    }
    
    @IBAction func buttonReleased(_ sender: UIButton) {
        sender.backgroundColor = UIColor.yellow
    }
    
    @IBAction func metronomeButtonPressed(_ sender: UIButton) {
        metronome?.metronomeIsRunning = !(metronome?.metronomeIsRunning)!
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        globalClock.changeMetronomeSpeed(toBPM: sender.value)
    }
    
    @IBAction func exampleButtonPressed(_ sender: UIButton) {
        examplePlayer?.drumExampleIsPlaying = !(examplePlayer?.drumExampleIsPlaying)!
    }
    
}

@IBDesignable
class RoundableView: UIView {}
class RoundableStackView: UIStackView {}
class RoundableButton: UIButton {}
