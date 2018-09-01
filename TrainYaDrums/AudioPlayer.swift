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

    public let sampler = AKAppleSampler()
    private let sampleLoader: SampleLoader
    private var metronomeIndex = 0
    public var output: AKAppleSampler
    private let midiNotes = [36, 38, 42, 46, 47, 41, 50, 39, 37, 60, 61]

    init() {
        sampleLoader = SampleLoader(sampler: sampler)
        output = sampler
    }

    func play(noteTag: Int) {
        playSample(note: noteTag)
    }

    public func playMetronomeSound(beatIndex: Int) {
        if beatIndex == 0 {
            play(noteTag: 9)
        } else {
            play(noteTag: 10)
        }
    }

    public func playSample(note: Int) {
        let midiNoteNumber = midiNotes[note] - 12
        if note == 42 { stopSample(note: 46) }
        do {
            try sampler.play(noteNumber: MIDINoteNumber(midiNoteNumber))
        } catch {
            print("Error while playing drums.")
        }
    }

    private func stopSample(note: Int) {
        do {
            try sampler.stop(noteNumber: MIDINoteNumber(note))
        } catch {
            print("Error while playing drums.")
        }
    }

}
