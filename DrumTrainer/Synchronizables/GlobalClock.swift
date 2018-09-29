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
    var beatIndex: Int = 0
    var quaterBeatIndex: Int = 0
    var eighthBeatIndex: Int = 0
    var bpmValue: Int = 120
    var timer: Repeater?

    func runGlobalCLock() {
        beatIndex = 0
        timer = Repeater.every(.seconds(calculateEighthIntervalPerSecond())) { _ in
            self.eighthBeatNotification()
        }
        timer?.start()
    }

    func calculateEighthIntervalPerSecond() -> Double {
        return (1/(Double(bpmValue)/60.0))/8
    }

    func changeBpmValue(toBPM: Float) {
        timer?.pause()
        bpmValue = Int(toBPM)
        runGlobalCLock()
    }

    func globalClockNotification() {
        if beatIndex == 0 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "globalClockBar"), object: nil)
        }
        let name = Notification.Name(rawValue: "globalClockBeat")
        NotificationCenter.default.post(name: name, object: nil)
        if beatIndex == 3 {
            beatIndex = 0
            eighthBeatIndex = 0
        } else {
            beatIndex += 1
        }
    }

    func eighthBeatNotification() {
        DispatchQueue.main.sync {
            let notificationName = Notification.Name(rawValue: "eighthNote")
            NotificationCenter.default.post(name: notificationName, object: nil)
            switch self.eighthBeatIndex {
            case 0, 8, 16, 24:
                let name = Notification.Name(rawValue: "globalClockBeat")
                NotificationCenter.default.post(name: name, object: nil)
            default:
                break
            }
            if self.eighthBeatIndex < 31 {
                self.eighthBeatIndex += 1
            } else {
                self.eighthBeatIndex = 0
            }
        }
    }

}
