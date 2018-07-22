//
//  ExamplePlayer.swift
//  DrumTrainer
//
//  Created by NVT on 22.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

protocol ExamplePlayerDelegate {
    func playDrum(beatpadNumber: Int)
}

class ExamplePlayer {
    
    var timer = Timer()
    var examplePartIndex = 0
    let exampleBeatSequence = [0, 2, 1, 2, 0, 2, 1, 2]
    var delegate : ExamplePlayerDelegate?
    
    // MARK: - share BPM values with metronome (create separate BPM class)
    // MARK: - add delegation to play button through controller
    
    func playExample() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1/(120/30.0)),
                                     target: self, selector: #selector(playExamplePart),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func playExamplePart() {
        print(exampleBeatSequence[examplePartIndex])
        delegate?.playDrum(beatpadNumber: exampleBeatSequence[examplePartIndex])
        if examplePartIndex < 7 {
            examplePartIndex += 1
        } else {
            examplePartIndex = 0
        }
    }
    
}
