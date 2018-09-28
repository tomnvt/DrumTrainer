//
//  Metronom.swift
//  DrumTrainer
//
//  Created by NVT on 09.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AVFoundation
import AudioKit

protocol MetronomeDelegate: AnyObject {
    func metronomeClickAndFlash(beatIndex: Int)
}

class Metronome: Synchronizable {

    var beatIndex = 0

    var metronomeIsRunning: Bool = false
    weak var delegate: MetronomeDelegate?

    override init() {
        super.init()
    }

    override func playSynchronized() {
        if metronomeIsRunning {
            delegate?.metronomeClickAndFlash(beatIndex: beatIndex)
        }
        increaseBeatIndex()
    }

    private func increaseBeatIndex() {
        if beatIndex < 3 {
            beatIndex += 1
        } else {
            beatIndex = 0
        }
    }

    override func firstBeatAction() {
        beatIndex = 0
    }

}
