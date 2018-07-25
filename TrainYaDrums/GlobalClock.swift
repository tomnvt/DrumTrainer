//
//  GlobalClock.swift
//  DrumTrainer
//
//  Created by NVT on 25.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class GlobalCloss {
    
    var timer = Timer()
    var beatIndex : Int = 0
    var beats : [Int] = [1, 2, 3, 4]
    var bpmValue : Int = 120
    
    func runGlobalCLock() {
        beatIndex = 0
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1/(Double(bpmValue)/60.0)),
                                     target: self, selector: #selector(self.globalClockTest),
                                     userInfo: nil, repeats: true)
    }
    
    func changeMetronomeSpeed(toBPM: Float) {
        timer.invalidate()
        bpmValue = Int(toBPM)
        runGlobalCLock()
    }
    
    @IBAction func globalClockTest() {
        print(beats[beatIndex])
        if beatIndex == 3 {
            beatIndex = 0
        } else {
            beatIndex += 1
        }
    }
    
}
