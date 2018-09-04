//
//  SimpleHouseBeatExample.swift
//  DrumTrainer
//
//  Created by NVT on 10.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class SimpleHouseBeatExample: BeatExample {

    var bars = 1

    override init() {
        super.init()
        firstBarDrumNotes[0] = [1, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0]
        firstBarDrumNotes[1] = [0, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                1, 0, 0, 0, 0, 0, 0, 0]
        firstBarDrumNotes[2] = [0, 0, 0, 0, 1, 0, 0, 0,
                                0, 0, 0, 0, 1, 0, 0, 0,
                                0, 0, 0, 0, 1, 0, 0, 0,
                                0, 0, 0, 0, 1, 0, 0, 0]
    }

}
