//
//  GlobalClock.swift
//  DrumTrainer
//
//  Created by NVT on 25.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import Repeat

class GlobalClock {

    var eighthBeatTimer: Timer = Timer()
    var eighthBeatIndex: Int = 0
    var bpmValue: Int = 120
    var timer: Repeater?
    static var staticBeatIndex: Int = -1
    static var staticEightNoteIndex: Int = 0

    func runGlobalCLock() {
        timer = Repeater.every(.seconds(calculateEighthNoteIntervalPerSecond())) { _ in
            self.eighthBeatNotification()
        }
        timer?.start()
    }

    func calculateEighthNoteIntervalPerSecond() -> Double {
        return (1/(Double(bpmValue)/60.0))/8
    }

    func changeBpmValue(toBPM: Float) {
        timer?.pause()
        bpmValue = Int(toBPM)
        runGlobalCLock()
    }

    func eighthBeatNotification() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .GlobalClockEighthNote, object: nil)
            switch self.eighthBeatIndex {
            case 0, 8, 16, 24:
                NotificationCenter.default.post(name: .GlobalClockBeat, object: nil)
                self.increaseBeatIndex()
            default:
                break
            }
            if self.eighthBeatIndex < 31 {
                self.eighthBeatIndex += 1
                GlobalClock.staticEightNoteIndex += 1
            } else {
                self.eighthBeatIndex = 0
                GlobalClock.staticEightNoteIndex = 0
            }
        }
    }

    func increaseBeatIndex() {
        if GlobalClock.staticBeatIndex == 3 {
            GlobalClock.staticBeatIndex = 0
        } else {
            GlobalClock.staticBeatIndex += 1
        }
    }

}
