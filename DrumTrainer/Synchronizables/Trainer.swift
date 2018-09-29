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
    var recorder = Recorder()
    var currentRoundScore: Int = 0

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

    func recordNoteIfTrainingModeIsOn(drumPadIndex: Int) {
        if Trainer.trainingModeIsOn && Trainer.trainingBarCount != 1 {
            recorder.recordPlayedNote(drumPadIndex: drumPadIndex)
        }
    }

    func compareRecordedAndExampleNotes() -> Float {
        let comparisonBase = compareTwoBeatNotes(firstBeatNotes: ExamplePlayer.exampleBeatNotes,
                                                 secondBeatNotes: EmptyExampleBeat.exampleBeatNotes)
        let exampleNotes = ExamplePlayer.exampleBeatNotes
        let recordedNotes = recorder.getRecordedNotes()
        var overallComparison: Float = 0.0
        for index in 0...15 {
            let drumPadComparison = compareTwoIntArray(firstArray: exampleNotes[index],
                                                       secondArray: recordedNotes[index])
            overallComparison += drumPadComparison
        }
        overallComparison /= 16
        return calculateCustomRangePercentage(lowBound: comparisonBase,
                                              topBound: 1.0,
                                              targetValue: overallComparison)
    }

    func compareTwoBeatNotes(firstBeatNotes: [[Int]], secondBeatNotes: [[Int]]) -> Float {
        var overallComparison: Float = 0.0
        for index in 0...15 {
            let drumPadComparison = compareTwoIntArray(firstArray: firstBeatNotes[index],
                                                       secondArray: secondBeatNotes[index])
            overallComparison += drumPadComparison
        }
        overallComparison /= 16
        return overallComparison
    }

    func compareTwoIntArray(firstArray: [Int], secondArray: [Int]) -> Float {
        guard firstArray.count == secondArray.count else {
            print("Arrays doesn't have the same length!")
            return 0
        }
        var comparisonResults: [Int] = []
        for index in 0..<firstArray.count {
            if firstArray[index] == secondArray[index] {
                comparisonResults.append(1)
            } else {
                comparisonResults.append(0)
            }
        }
        var matchPercentage: Float = 0
        for comparisonResult in comparisonResults {
            matchPercentage += Float(comparisonResult)
        }
        matchPercentage /= Float(comparisonResults.count)
        return matchPercentage
    }

    override func eighthNoteAction() {
        if eighthNoteIndex == 31 {
            if Trainer.trainingBarCount != 1 {
                currentRoundScore = Int(compareRecordedAndExampleNotes())
                print("Current round score is \(currentRoundScore)")
                recorder.resetRecord()
            }
        }
    }

    func calculateCustomRangePercentage(lowBound: Float, topBound: Float, targetValue: Float) -> Float {
        let range = calculateRoundedRange(lowBound: lowBound, topBound: topBound)
        let roundedTargetValueInRange = roundToTwoDecimalNumbers(topBound - targetValue)
        let percentage = 100 - ((roundedTargetValueInRange * 100) / range)
        return percentage
    }

    func calculateRoundedRange(lowBound: Float, topBound: Float) -> Float {
        var roundedRange = ((topBound - lowBound) * 1000)
        roundedRange.round()
        roundedRange /= 1000
        return roundedRange
    }

    func roundToTwoDecimalNumbers(_ value: Float) -> Float {
        var value = value * 1000
        value.round()
        value /= 1000
        return value
    }

}
