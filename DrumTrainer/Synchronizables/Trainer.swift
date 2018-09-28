//
//  Trainer.swift
//  DrumTrainer
//
//  Created by NVT on 28/09/2018.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class Trainer: Synchronizable {

    static var trainingModeIsOn: Bool = false
    static var trainingBarCount: Int = 1

    func turnTrainingModeOnOrOff() {
        Trainer.trainingModeIsOn = !Trainer.trainingModeIsOn
    }

    func increaseTrainingBarCount() {
        if Trainer.trainingBarCount < 2 {
            Trainer.trainingBarCount += 1
        } else {
            Trainer.trainingBarCount = 1
        }
    }

    override func firstBeatAction() {
        increaseTrainingBarCount()
    }

}
