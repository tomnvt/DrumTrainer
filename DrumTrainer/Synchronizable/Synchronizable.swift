//
//  Synchronizable.swift
//  DrumTrainer
//
//  Created by NVT on 29.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class Synchronizable {

    var beatIndices: [Int] = [0, 1, 2, 3]
    var currentBeatIndex: Int = 0
    var eighthNoteIndex = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(playSynchronized),
                                               name: .GlobalClockBeat, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setBeatIndexToZero),
                                               name: .GlobalClockBar, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(synchronizeWithGlobalClock),
                                               name: .GlobalClockBeat, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(increaseEighthNoteIndex),
                                               name: .GlobalClockEighthNote, object: nil)
    }

    @objc func playSynchronized() {}

    @objc func setBeatIndexToZero() {
        currentBeatIndex = 0
        eighthNoteIndex = 0
    }

    @objc func synchronizeWithGlobalClock() {
        if currentBeatIndex < 3 {
            currentBeatIndex += 1
        } else {
            currentBeatIndex = 0
        }
    }

    @objc func firstBeatAction() {}

    @objc func eighthNoteAction() {}

    @objc func increaseEighthNoteIndex() {
        eighthNoteAction()
        if eighthNoteIndex < 31 {
            eighthNoteIndex += 1
        } else {
            eighthNoteIndex = 0
            firstBeatAction()
        }
    }

}
