//
//  SimpleBrokenBeatExample.swift
//  DrumTrainer
//
//  Created by NVT on 10.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class SimpleBrokenBeatExample: BeatExample {

    override init() {
        super.init()
        firstBarDrumNotes[0] = [1, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 1, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 1, 0]
        firstBarDrumNotes[1] = [0, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0]
        firstBarDrumNotes[2] = [1, 0, 0, 0, 1, 0, 0, 0,
                                1, 0, 0, 0, 1, 0, 0, 0,
                                1, 0, 0, 0, 1, 0, 0, 0,
                                1, 0, 0, 0, 1, 0, 0, 0]

    }

}
