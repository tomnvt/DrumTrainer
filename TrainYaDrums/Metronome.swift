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
    func metronomeClickAndFlash()
}

class Metronome: Synchronizable {

    var metronomeIsRunning: Bool = false
    weak var delegate: MetronomeDelegate?

    override init() {
        super.init()
    }

    override func playSynchronized() {
        guard metronomeIsRunning else {
            return
        }
        delegate?.metronomeClickAndFlash()
    }

}
