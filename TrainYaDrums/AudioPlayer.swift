//
//  AudioPlayer.swift
//  DrumTrainer
//
//  Created by NVT on 18.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AudioKit

class AudioPlayer {

    private let audioPlayerSampleLoader = AudioPlayerSampleLoader()
    private var metronomeIndex = 0
    public var output: AKAppleSampler

    init() {
        output = audioPlayerSampleLoader.sampler
    }

    func play(noteTag: Int) {
        audioPlayerSampleLoader.playSample(note: noteTag)
    }

    public func playMetronomeSound() {
        if metronomeIndex == 0 {
            play(noteTag: 9)
        } else {
            play(noteTag: 10)
        }
        increaseMetronomeIndex()
    }

    private func increaseMetronomeIndex() {
        if metronomeIndex < 3 {
            metronomeIndex += 1
        } else {
            metronomeIndex = 0
        }
    }

}
