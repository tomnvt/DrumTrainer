//
//  Recorder.swift
//  DrumTrainer
//
//  Created by NVT on 29/09/2018.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class Recorder: Synchronizable {

    var recordedNotes: [[Int]] = []

    override init() {
        super.init()
        recordedNotes = EmptyExampleBeat.exampleBeatNotes
    }

    func resetRecord() {
        recordedNotes = EmptyExampleBeat.exampleBeatNotes
    }

    func recordPlayedNote(drumPadIndex: Int) {
        recordedNotes[drumPadIndex][eighthNoteIndex] = 1
    }

    func getRecordedNotes() -> [[Int]] {
        return recordedNotes
    }

}
