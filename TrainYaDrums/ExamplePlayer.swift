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
    let metronome : Metronome?

    // MARK: - share BPM values with metronome (create separate BPM class)
    init(metronome: Metronome) {
        self.metronome = metronome
    }

    func playExample() {
            if metronome?.beatIndex == 3 {
                drumExampleIsPlaying = !drumExampleIsPlaying
                if drumExampleIsPlaying {
                    timer = Timer.scheduledTimer(timeInterval: TimeInterval(1/(120/30.0)),
                                                 target: self, selector: #selector(playExamplePart),
                                                 userInfo: nil, repeats: true)
                } else {
                    timer.invalidate()
                    examplePartIndex = 0
                }
            }
    }

    @objc func playExamplePart() {
        delegate?.playDrum(beatpadNumber: exampleBeatSequence[examplePartIndex])
        if examplePartIndex < 7 {
            examplePartIndex += 1
        } else {
            examplePartIndex = 0
        }
    }

}
