//
//  AnimationIndexCounter.swift
//  DrumTrainer
//
//  Created by NVT on 29/09/2018.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class AnimationIndexCounter: Synchronizable {

    var sectionIndex: Int = 0
    var sectionEightNoteIndex: Int = 0

//    override func increaseEighthNoteIndex() {
//        if eighthNoteIndex == 8 {
//            increaseSectionIndex()
//            eighthNoteIndex = 0
//        }
//        eighthNoteIndex += 1
//    }
    
    override func eighthNoteAction() {
        if sectionEightNoteIndex == 8 {
            increaseSectionIndex()
            sectionEightNoteIndex = 0
        }
        sectionEightNoteIndex += 1
    }

    func increaseSectionIndex() {
        if sectionIndex != 3 {
            sectionIndex += 1
        } else {
            sectionIndex = 0
        }
    }

    override func firstBeatAction() {
        sectionIndex = 0
    }

}
