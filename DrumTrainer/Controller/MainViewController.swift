//
//  MainViewController.swift
//  DrumTrainer
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MetronomeDelegate, ExamplePlayerDelegate, TrainerDelegate {

    @IBOutlet weak var bpmValueLabel: UILabel!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var metronomeButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var matchPercentageLabel: UILabel!
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
        trainer.delegate = self

        appendAllDrumPadsIntoDrumPadsArray()
        setDefaultBeatIfNotSelected()
        setDefaultBpmValueIfNotSet()
        setDefaultMetronomeVolumeIfNotSet()
        setBpmAndBpmSliderBySavedValue()
        setVolumeSliderSavedValue()
        globalClock.runGlobalCLock()
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

    func setBpmAndBpmSliderBySavedValue() {
        let savedBpmValue = Float(defaults.integer(forKey: "bpmValue"))
        globalClock.bpmValue = Int(savedBpmValue)
        bpmSlider.setValue(savedBpmValue, animated: false)
    }

    @IBAction func drumPadTapped(_ sender: UIButton) {
        audioPlayer.playDrumSample(note: sender.tag)
        sender.blackToYellowBlink()
        trainer.recordNoteIfTrainingModeIsOn(drumPadIndex: sender.tag)
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
        if Trainer.trainingModeIsOn {
            metronome.metronomeIsRunning = true
            examplePlayer.drumExampleIsPlaying = true
            showMatchPercentaageLabel()
        } else {
            metronome.metronomeIsRunning = false
            examplePlayer.drumExampleIsPlaying = false
            hideMatchPercentaageLabel()
        }
    }

    @IBAction func editButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "BeatEditViewController", sender: sender)
        }
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

    func showCurrentRoundResult(score: Int) {
        UIView.transition(with: self.matchPercentageLabel,
                          duration: 0.5,
                          options: .transitionCrossDissolve, animations: {
                            self.matchPercentageLabel.text = "Beat match: \(String(score)) %"
        }, completion: nil)
        matchPercentageLabel.cornerRadius = 15
    }

    func showMatchPercentaageLabel() {
        matchPercentageLabel.text = "Repeat after example"
        UIView.animate(withDuration: 0.5, animations: {
            self.matchPercentageLabel.layer.backgroundColor = UIColor.black.cgColor
        })
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
            UIView.transition(with: self.matchPercentageLabel,
                              duration: 0.25,
                              options: .transitionCrossDissolve, animations: {
                                self.matchPercentageLabel.textColor = .white
            }, completion: nil)
        })
    }

    func hideMatchPercentaageLabel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.matchPercentageLabel.layer.backgroundColor = UIColor.clear.cgColor
        })
        UIView.transition(with: self.matchPercentageLabel,
                          duration: 0.5,
                          options: .transitionCrossDissolve, animations: {
                            self.matchPercentageLabel.textColor = .clear
        })
    }

}
