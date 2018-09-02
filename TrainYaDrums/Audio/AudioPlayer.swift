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

    private let drumSampler: Sampler
    private let metronomeSampler: Sampler
    private let audioMixer = AKMixer()
    private var metronomeIndex = 0
    public let output: AKNode
    private let midiNotes = [36, 38, 42, 46, 47, 41, 50, 39, 37, 60, 61]

    init() {
        let samplerFactory = SamplerFactory()
        drumSampler = samplerFactory.makesSamplerOf(sampleType: .drums)
        metronomeSampler = samplerFactory.makesSamplerOf(sampleType: .metronome)
        audioMixer.connect(input: drumSampler)
        audioMixer.connect(input: metronomeSampler)
        output = audioMixer
    }

    func play(noteTag: Int) {
        playSample(note: noteTag)
    }

    public func changeMetronomeVolume(toValue: Double) {
        metronomeSampler.volume = toValue
    }

    public func playMetronomeSound(beatIndex: Int) {
        if beatIndex == 0 {
            playSample(sampler: metronomeSampler, note: 9)
        } else {
            playSample(sampler: metronomeSampler, note: 10)
        }
    }

    public func playSample(note: Int) {
        let midiNoteNumber = midiNotes[note] - 12
        if note == 42 { stopSample(note: 46) }
        do {
            try drumSampler.play(noteNumber: MIDINoteNumber(midiNoteNumber))
        } catch {
            print("Error while playing drums.")
        }
    }

    public func playSample(sampler: AKAppleSampler, note: Int) {
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
            try drumSampler.stop(noteNumber: MIDINoteNumber(note))
        } catch {
            print("Error while playing drums.")
        }
    }

}
