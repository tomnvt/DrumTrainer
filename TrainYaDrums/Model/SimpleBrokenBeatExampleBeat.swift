//
//  SimpleBrokenBeatExampleBeat.swift
//  DrumTrainer
//
//  Created by NVT on 07.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class SimpleBrokenBeatExampleBeat: ExampleBeatNotes {

    var exampleBeatNotes = { () -> [[Int]] in
        var drumPadNotes: [[Int]] = []
        let eighthsArray = [0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0]
        for _ in 0...15 {
            drumPadNotes.append(eighthsArray)
        }
        drumPadNotes[0] = [1, 0, 0, 0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 1, 0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0, 0, 1, 0]
        drumPadNotes[1] = [0, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0]
        drumPadNotes[2] = [1, 0, 0, 0, 1, 0, 0, 0,
                           1, 0, 0, 0, 1, 0, 0, 0,
                           1, 0, 0, 0, 1, 0, 0, 0,
                           1, 0, 0, 0, 1, 0, 0, 0]
        return drumPadNotes
    }()

    override init() {
        super.init()
        saveExampleBeatToRealm(beatNotes: exampleBeatNotes, beatName: "Simple Broken Beat")
        firstBarDrumNotes = exampleBeatNotes
    }

}
