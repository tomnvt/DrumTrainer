//
//  AudioPlayer.swift
//  DrumTrainer
//
//  Created by NVT on 18.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import AudioKit

class AudioPlayer {

    private let drumSampler: Sampler
    private let metronomeSampler: Sampler
    private let audioMixer = AKMixer()
    private var metronomeIndex = 0
    private let midiNotes = [36, 38, 42, 46, 47,
                             41, 50, 39, 37, 60,
                             61, 62, 63, 64, 65,
                             66, 67, 68, 69, 70]

    init() {
        let samplerFactory = SamplerFactory()
        drumSampler = samplerFactory.makesSamplerOf(sampleType: .drums)
        metronomeSampler = samplerFactory.makesSamplerOf(sampleType: .metronome)
        audioMixer.connect(input: drumSampler)
        audioMixer.connect(input: metronomeSampler)
        AudioKit.output = audioMixer
        tryToStartAudioKit()
    }

    func tryToStartAudioKit() {
        do {
            try AudioKit.start()
        } catch {
            print("Error while trying to start AudioKit!")
        }
    }

    public func changeMetronomeVolume(toValue: Double) {
        let metronomeVolumeValue = toValue / 100
        metronomeSampler.volume = metronomeVolumeValue
    }

    public func playMetronomeSample(beatIndex: Int) {
        if beatIndex == 0 {
            playSample(sampler: metronomeSampler, note: 9)
        } else {
            playSample(sampler: metronomeSampler, note: 10)
        }
    }

    public func playDrumSample(note: Int) {
        playSample(sampler: drumSampler, note: note)
    }

    public func playSample(sampler: AKAppleSampler, note: Int) {
        let midiNoteNumber = midiNotes[note] - 12
        if note == 42 { stopSample(sampler: drumSampler, note: 46) }
        do {
            try sampler.play(noteNumber: MIDINoteNumber(midiNoteNumber))
        } catch {
            print("Error while playing note \(String(note)) in sampler: \(String(describing: sampler.self))" )
        }
    }

    private func stopSample(sampler: AKAppleSampler, note: Int) {
        do {
            try sampler.stop(noteNumber: MIDINoteNumber(note))
        } catch {
            print("Error while stopping sample!")
        }
    }

}
