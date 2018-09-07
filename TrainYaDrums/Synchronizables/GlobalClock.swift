//
//  GlobalClock.swift
//  DrumTrainer
//
//  Created by NVT on 25.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class GlobalClock {

    var eighthBeatTimer: Timer = Timer()
    var beatIndex: Int = 0
    var quaterBeatIndex: Int = 0
    var eighthBeatIndex: Int = 0
    var bpmValue: Int = 120

    func runGlobalCLock() {
        beatIndex = 0
        eighthBeatTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(calculateEighthIntervalPerSecond()),
                                               repeats: true,
                                               block: {_ in self.eighthBeatNotification()})
    }

    func calculateEighthIntervalPerSecond() -> Double {
        return (1/(Double(bpmValue)/60.0))/8
    }

    func changeBpmValue(toBPM: Float) {
        eighthBeatTimer.invalidate()
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
        print("eighth note: " + String(eighthBeatIndex))
        let notificationName = Notification.Name(rawValue: "eighthNote")
        NotificationCenter.default.post(name: notificationName, object: nil)
        switch eighthBeatIndex {
        case 0, 8, 16, 24:
            let name = Notification.Name(rawValue: "globalClockBeat")
            NotificationCenter.default.post(name: name, object: nil)
        default:
            break
        }
        if eighthBeatIndex < 31 {
            eighthBeatIndex += 1
        } else {
            eighthBeatIndex = 0
        }
    }

}
