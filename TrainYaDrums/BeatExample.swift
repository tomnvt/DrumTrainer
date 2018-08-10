//
//  File.swift
//  DrumTrainer
//
//  Created by NVT on 10.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class BeatExample {

    var oneBarDrumNotes: [[Int]]

    var firstBarDrumNotes: [[Int]]
    var secondBarDrumNotes: [[Int]]
    var thirdBarDrumNotes: [[Int]]
    var fourthBarDrumNotes: [[Int]]

    init() {
        oneBarDrumNotes = { () -> [[Int]] in
            var drumPadNotes: [[Int]] = [[]]
            let eighthsArray = [0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0]
            for _ in 0...15 {
                drumPadNotes.append(eighthsArray)
            }
            return drumPadNotes
        }()

        firstBarDrumNotes = oneBarDrumNotes
        secondBarDrumNotes = oneBarDrumNotes
        thirdBarDrumNotes = oneBarDrumNotes
        fourthBarDrumNotes = oneBarDrumNotes

    }

}
