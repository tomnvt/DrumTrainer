//
//  File.swift
//  DrumTrainer
//
//  Created by NVT on 10.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class BeatExample {

    var notes: Results<DrumpadEighthNotes>?
    @objc var oneBarDrumNotes = { () -> [[Int]] in
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

    var firstBarDrumNotes: [[Int]] = []

}
