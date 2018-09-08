//
//  FirstBarViewController.swift
//  DrumTrainer
//
//  Created by NVT on 08.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

class BeatBarEditViewContoller: UIViewController {


    @IBOutlet weak var currentBarIndexLabel: UILabel!

    var currentBarIndex = 1
    var eighthNoteIndex = 0

    let globalClockBeat = Notification.Name(rawValue: "globalClockBeat")
    let globalClockEighthNote = Notification.Name(rawValue: "eighthNote")

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(resetEighthNoteIndex),
                                               name: globalClockBeat, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(animateLoopProgress),
                                               name: globalClockEighthNote, object: nil)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
    }

    func decreaseCurrentBarIndex() {
        if currentBarIndex == 1 {
            currentBarIndex = 4
        } else {
            currentBarIndex -= 1
        }
    }

    func increaseCurrentBarIndex() {
        if currentBarIndex < 4 {
            currentBarIndex += 1
        } else {
            currentBarIndex = 1
        }
    }

    func updateCurrentBarIndexLabel() {
        currentBarIndexLabel.text = "\(currentBarIndex) / 4"
    }

    @IBAction func previousBarButtonPressed(_ sender: UIButton) {
        decreaseCurrentBarIndex()
        updateCurrentBarIndexLabel()
    }

    @IBAction func nextBarButtonPressed(_ sender: UIButton) {
        increaseCurrentBarIndex()
        updateCurrentBarIndexLabel()
    }

    @objc func animateLoopProgress() {
        print(eighthNoteIndex)
        if eighthNoteIndex < 31 {
            eighthNoteIndex += 1
        } else {
            eighthNoteIndex = 0
        }
    }

    @objc func resetEighthNoteIndex() {
        eighthNoteIndex = 0
    }

}
