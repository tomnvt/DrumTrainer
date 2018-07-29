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
    var drumExampleIsPlaying = false

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(playExamplePart), name: Notification.Name(rawValue: "globalClockBeat"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setExamplePartIndexZero), name: Notification.Name(rawValue: "globalClockBar"), object: nil)
    }

    @objc func setExamplePartIndexZero() {
        examplePartIndex = 0
        print("Example Player Zero")
    }
    
    @objc func playExamplePart() {
        guard drumExampleIsPlaying else {
            return
        }
        delegate?.playDrum(beatpadNumber: exampleBeatSequence[examplePartIndex])
        if examplePartIndex < 7 {
            examplePartIndex += 1
        } else {
            examplePartIndex = 0
        }
    }

}
