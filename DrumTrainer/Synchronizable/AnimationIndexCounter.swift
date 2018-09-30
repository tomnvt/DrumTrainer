//
//  AnimationIndexCounter.swift
//  DrumTrainer
//
//  Created by NVT on 29/09/2018.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class AnimationIndexCounter: Synchronizable {

    var sectionIndex: Int = GlobalClock.staticBeatIndex
    var sectionEightNoteIndex: Int = -1

    override func eighthNoteAction() {
        let beats = [0, 8, 16, 24]
        if sectionEightNoteIndex == 7 {
            sectionEightNoteIndex = -1
        }
        sectionEightNoteIndex += 1
        if beats.contains(GlobalClock.staticEightNoteIndex) {
            sectionEightNoteIndex = -1
        }
        sectionIndex = GlobalClock.staticBeatIndex
    }

    func increaseSectionIndex() {
        if sectionIndex != 3 {
            sectionIndex += 1
        } else {
            sectionIndex = 0
        }
        print("Section index: \(sectionIndex)")
    }

    override func setBeatIndexToZero() {
        sectionIndex = 0
    }

}
