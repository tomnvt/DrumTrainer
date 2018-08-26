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

    func playDrum(drumPadIndex: [Int]) {
        for drum in drumPadIndex {
            print("drum pad with index " + String(drumPadIndex[0]) + " is going to be pressed")
            touchDownDrumPad[drum].sendActions(for: .touchDown)
            print("drum pad with index " + String(drumPadIndex[0]) + " pressed")
        }
    }

    func metronomeButtonFlash() {
        audioPlayer.playMetronomeSound()
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

    var touchDownDrumPad: [RoundableButton] = []

    let defaults: UserDefaults = UserDefaults.standard

    var audioPlayer = AudioPlayer()

    let drums: Drums = Drums()
    var metronome: Metronome = Metronome()
    var examplePlayer: ExamplePlayer = ExamplePlayer()
    let globalClock: GlobalClock = GlobalClock()

    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
        examplePlayer.delegate = self
        drums.loadDrums()
        AudioKit.output = audioPlayer.output
        tryToStartAudioKit()
        setBpmSliderBySavedValue()
        appendAllDrumPadsIntoDrumPadsArray()
        globalClock.runGlobalCLock()
    }

    func appendAllDrumPadsIntoDrumPadsArray() {
        touchDownDrumPad.append(drumPad1)
        touchDownDrumPad.append(drumPad2)
        touchDownDrumPad.append(drumPad3)
        touchDownDrumPad.append(drumPad4)
        touchDownDrumPad.append(drumPad5)
        touchDownDrumPad.append(drumPad6)
        touchDownDrumPad.append(drumPad7)
        touchDownDrumPad.append(drumPad8)
    }

    func setBpmSliderBySavedValue() {
        bpmSlider.setValue(Float(defaults.integer(forKey: "bpmValue")), animated: false)
    }

    func tryToStartAudioKit() {
        do {
            try AudioKit.start()
        } catch {
            print("Error while starting AudioKit.")
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        audioPlayer.play(noteTag: sender.tag)
        sender.yellowBlink()
    }

    @IBAction func buttonReleased(_ sender: UIButton) {
        sender.backgroundColor = UIColor.yellow
    }

    @IBAction func metronomeButtonPressed(_ sender: UIButton) {
        print("metronomeButtonPressed")
        print(metronome.metronomeIsRunning)
        metronome.metronomeIsRunning = !metronome.metronomeIsRunning
        print(metronome.metronomeIsRunning)
    }

    @IBAction func bpmSliderChanged(_ sender: UISlider) {
        globalClock.changeBpmValue(toBPM: sender.value)
    }

    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        metronome.playerVolume = sender.value
    }

    @IBAction func exampleButtonPressed(_ sender: UIButton) {
        examplePlayer.drumExampleIsPlaying = !examplePlayer.drumExampleIsPlaying
    }

}

@IBDesignable
class RoundableView: UIView {}
class RoundableStackView: UIStackView {}
class RoundableButton: UIButton {}
