//
//  ExamplePlayer.swift
//  DrumTrainer
//
//  Created by NVT on 22.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

protocol ExamplePlayerDelegate {
    func playDrum(beatpadNumber: [Int])
}

class ExamplePlayer {

    var timer = Timer()
    var examplePartIndex = 0
    let exampleBeatSequence = [[0], [2], [0, 1], [2], [0], [2], [0, 1], [2]]
    var delegate : ExamplePlayerDelegate?
    var beatIndices = [0, 1, 2, 3]
    var currentBeatIndex = 0
    var drumExampleIsPlaying = false

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(setExamplePartIndexZero), name: Notification.Name(rawValue: "globalClockBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playExamplePart), name: Notification.Name(rawValue: "globalClockBeat"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(synchronizeWithGlobalClock), name: Notification.Name(rawValue: "globalClockBeat"), object: nil)
    }

    @objc func setExamplePartIndexZero() {
        examplePartIndex = 0
    }
    
    @objc func playExamplePart() {
        guard drumExampleIsPlaying else {
            return
        }
        delegate?.playDrum(beatpadNumber: exampleBeatSequence[currentBeatIndex])
    }
    
    @objc func synchronizeWithGlobalClock() {
        print(beatIndices[currentBeatIndex])
        if currentBeatIndex < 3 {
            currentBeatIndex += 1
        } else {
            currentBeatIndex = 0
        }
    }
    
}
