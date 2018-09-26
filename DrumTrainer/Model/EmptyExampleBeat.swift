//
//  EmptyExampleBeat.swift
//  DrumTrainer
//
//  Created by NVT on 14.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class EmptyExampleBeat: ExampleBeatNotes {

    static var exampleBeatNotes = { () -> [[Int]] in
        var drumPadNotes: [[Int]] = []
        let eighthsArray = [0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0]
        for _ in 0...15 {
            drumPadNotes.append(eighthsArray)
        }
        return drumPadNotes
    }()

}
