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

    let globalClockBeat = Notification.Name(rawValue: "globalClockBeat")
    let globalClockBar = Notification.Name(rawValue: "globalClockBar")

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(playSynchronized),
                                               name: globalClockBeat, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setBeatIndexToZero),
                                               name: globalClockBar, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(synchronizeWithGlobalClock),
                                               name: globalClockBeat, object: nil)
    }

    @objc func playSynchronized() {}

    @objc func setBeatIndexToZero() {
        currentBeatIndex = 0
    }

    @objc func synchronizeWithGlobalClock() {
        if currentBeatIndex < 3 {
            currentBeatIndex += 1
        } else {
            currentBeatIndex = 0
        }
    }

}
