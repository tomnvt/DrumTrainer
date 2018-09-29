//
//  ViewController.swift
//  TrainYaDrums
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MetronomeDelegate, ExamplePlayerDelegate, NoteChangerDelegate {

    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var drumPad1: RoundableButton!
    @IBOutlet weak var drumPad2: RoundableButton!
    @IBOutlet weak var drumPad3: RoundableButton!
    @IBOutlet weak var drumPad4: RoundableButton!
    @IBOutlet weak var drumPad5: RoundableButton!
    @IBOutlet weak var drumPad6: RoundableButton!
    @IBOutlet weak var drumPad7: RoundableButton!
    @IBOutlet weak var drumPad8: RoundableButton!
    @IBOutlet weak var drumPad9: RoundableButton!
    @IBOutlet weak var drumPad10: RoundableButton!
    @IBOutlet weak var drumPad11: RoundableButton!
    @IBOutlet weak var drumPad12: RoundableButton!
    @IBOutlet weak var drumPad13: RoundableButton!
    @IBOutlet weak var drumPad14: RoundableButton!
    @IBOutlet weak var drumPad15: RoundableButton!
    @IBOutlet weak var drumPad16: RoundableButton!

    var drumPads: [RoundableButton] = []
    let defaults: UserDefaults = UserDefaults.standard
    var audioPlayer: AudioPlayer = AudioPlayer()
    let trainer: Trainer = Trainer()
    var metronome: Metronome = Metronome()
    var examplePlayer: ExamplePlayer = ExamplePlayer()
    let globalClock: GlobalClock = GlobalClock()

    override func viewDidLoad() {
        super.viewDidLoad()
        metronome.delegate = self
        examplePlayer.delegate = self
        appendAllDrumPadsIntoDrumPadsArray()
        globalClock.runGlobalCLock()
        setDefaultBeatIfNotSelected()
        setDefaultBpmValueIfNotSet()
        setDefaultMetronomeVolumeIfNotSet()
        setBpmSliderBySavedValue()
        setVolumeSliderSavedValue()
    }

    func appendAllDrumPadsIntoDrumPadsArray() {
        drumPads.append(drumPad1)
        drumPads.append(drumPad2)
        drumPads.append(drumPad3)
        drumPads.append(drumPad4)
        drumPads.append(drumPad5)
        drumPads.append(drumPad6)
        drumPads.append(drumPad7)
        drumPads.append(drumPad8)
        drumPads.append(drumPad9)
        drumPads.append(drumPad10)
        drumPads.append(drumPad11)
        drumPads.append(drumPad12)
        drumPads.append(drumPad13)
        drumPads.append(drumPad14)
        drumPads.append(drumPad15)
        drumPads.append(drumPad16)
    }

    func setDefaultBeatIfNotSelected() {
        if defaults.string(forKey: "currentlySelectedBeatName") == nil {
            defaults.set("Simple House", forKey: "currentlySelectedBeatName")
        }
    }

    func setDefaultBpmValueIfNotSet() {
        if defaults.integer(forKey: "bpmValue") == 0 {
            defaults.set(120, forKey: "bpmValue")
        }
    }

    func setDefaultMetronomeVolumeIfNotSet() {
        if defaults.float(forKey: "metronomeVolume") == 0 {
            defaults.set(100, forKey: "metronomeVolume")
        }
    }

    func setVolumeSliderSavedValue() {
        let currentMetronomeVolumeValue = defaults.float(forKey: "metronomeVolume")
        volumeSlider.setValue(currentMetronomeVolumeValue, animated: false)
    }

    func setBpmSliderBySavedValue() {
        bpmSlider.setValue(Float(defaults.integer(forKey: "bpmValue")), animated: false)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        audioPlayer.playDrumSample(note: sender.tag)
        sender.yellowBlink()
    }

    @IBAction func buttonReleased(_ sender: UIButton) {
        sender.backgroundColor = UIColor.yellow
    }

    @IBAction func metronomeButtonPressed(_ sender: UIButton) {
        metronome.metronomeIsRunning = !metronome.metronomeIsRunning
    }

    @IBAction func bpmSliderChanged(_ sender: UISlider) {
        globalClock.changeBpmValue(toBPM: sender.value)
        defaults.set(Int(sender.value), forKey: "bpmValue")
    }

    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        audioPlayer.changeMetronomeVolume(toValue: Double(sender.value))
        defaults.set(sender.value, forKey: "metronomeVolume")
    }

    @IBAction func exampleButtonPressed(_ sender: UIButton) {
        examplePlayer.drumExampleIsPlaying = !examplePlayer.drumExampleIsPlaying
    }

    @IBAction func trainButtonPressed(_ sender: UIButton) {
        trainer.turnTrainingModeOnOrOff()
    }

    func touchDownDrumPad(drumPadIndexes: [Int]) {
        for drum in drumPadIndexes {
            drumPads[drum].sendActions(for: .touchDown)
        }
    }

    func metronomeClickAndFlash(beatIndex: Int) {
        audioPlayer.playMetronomeSample(beatIndex: beatIndex)
        metronomeButton.orangeBlink()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? BeatEditViewController {
           viewController.delegate = self
            viewController.notes = ExamplePlayer.exampleBeatNotes
        }
    }

    func changeNote(drumPadIndex: Int, noteIndex: Int) {
        var currentNote = ExamplePlayer.exampleBeatNotes[drumPadIndex][noteIndex]
        if currentNote == 0 {
            currentNote = 1
        } else if currentNote == 1 {
            currentNote = 0
        }
        ExamplePlayer.exampleBeatNotes[drumPadIndex][noteIndex] = currentNote
    }

}
