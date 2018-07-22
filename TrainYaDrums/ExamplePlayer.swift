//
//  ExamplePlayer.swift
//  DrumTrainer
//
//  Created by NVT on 22.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class ExamplePlayer {
    
    var timer = Timer()
    var examplePartIndex = 0
    let exampleBeatSequence = [0, 2, 1, 2, 0, 2, 1, 2]
    
    // MARK: - share BPM values with metronome (create separate BPM class)
    // MARK: - add delegation to play button through controller
    
    func playExample() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1/(120/60.0)),
                                     target: self, selector: #selector(playExamplePart),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func playExamplePart() {
        print(exampleBeatSequence[examplePartIndex])
        if examplePartIndex < 7 {
            examplePartIndex += 1
        } else {
            examplePartIndex = 0
        }
    }
    
}