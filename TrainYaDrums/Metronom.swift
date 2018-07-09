//
//  Metronom.swift
//  DrumTrainer
//
//  Created by NVT on 09.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class Metronome {
    
    var timer = Timer()
    var metronomeIsRunning : Bool = false
    var beatIndex : Int = 0
    var beats : [Int] = [1, 2, 3, 4]
    
    func runMetronomeWith(BPM: Float) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1/(BPM/60)),
                                     target: self, selector: #selector(self.playClick),
                                     userInfo: nil, repeats: true)
        metronomeIsRunning = true
    }
    
    func stopMetronome() {
        timer.invalidate()
        metronomeIsRunning = false
    }
    
    func changeMetronomeSpeed(toBPM: Float) {
        stopMetronome()
            runMetronomeWith(BPM: toBPM)
    }
    
    @objc func playClick() {
        print("Beat number \(beats[beatIndex])")
        beatIndex += 1
        if beatIndex == 4 {
            beatIndex = 0
        }
    }
}
