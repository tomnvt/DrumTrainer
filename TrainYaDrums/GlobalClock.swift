//
//  GlobalClock.swift
//  DrumTrainer
//
//  Created by NVT on 25.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class GlobalClock {

    var timer: Timer = Timer()
    var halfBeatTimer: Timer = Timer()
    var quaterBeatTimer: Timer = Timer()
    var eighthBeatTimer: Timer = Timer()
    var beatIndex: Int = 0
    var halfBeatIndex: Int = 0
    var quaterBeatIndex: Int = 0
    var eighthBeatIndex: Int = 0
    var beats: [Int] = [1, 2, 3, 4]
    var bpmValue: Int = 120

    func runGlobalCLock() {
        beatIndex = 0
        eighthBeatTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(calculateEighthBeatPerSecondValue()),
                                               repeats: true,
                                               block: {_ in self.eighthBeatNotification()})
    }

    func calculateBeatPerSecondValue() -> Double {
        return 1/(Double(bpmValue)/60.0)
    }

    func calculateEighthBeatPerSecondValue() -> Double {
        return (1/(Double(bpmValue)/60.0))/8
    }

    func changeBpmValue(toBPM: Float) {
        timer.invalidate()
        halfBeatTimer.invalidate()
        quaterBeatTimer.invalidate()
        eighthBeatTimer.invalidate()
        bpmValue = Int(toBPM)
        runGlobalCLock()
    }

    func globalClockNotification() {
        print("Full beat in full")
        if beatIndex == 0 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "globalClockBar"), object: nil)
        }
        let name = Notification.Name(rawValue: "globalClockBeat")
        NotificationCenter.default.post(name: name, object: nil)
        if beatIndex == 3 {
            beatIndex = 0
            halfBeatIndex = 0
            quaterBeatIndex = 0
            eighthBeatIndex = 0
        } else {
            beatIndex += 1
        }
    }

    func eighthBeatNotification() {
        switch eighthBeatIndex {
        case 0, 7, 15, 23:
            print("Full beat by eights")
            globalClockNotification()
        default:
            break
        }
        print("eighth note: " + String(eighthBeatIndex))
        let notificationName = Notification.Name(rawValue: "eighthNote")
        NotificationCenter.default.post(name: notificationName, object: nil)
        if eighthBeatIndex < 31 {
            eighthBeatIndex += 1
        } else {
            eighthBeatIndex = 0
        }
    }

}
