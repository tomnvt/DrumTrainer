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
    private let midiNotes = [36, 38, 42, 46, 47, 41, 50, 39, 37, 60, 61]
    private var metronomeIndex = 0

    private var sampleFilesArray: [AKAudioFile?] = {
                var bassDrumFile: AKAudioFile?
                var snareDrumFile: AKAudioFile?
                var closedHiHatFile: AKAudioFile?
                var loTomFile: AKAudioFile?
                var midTomFile: AKAudioFile?
                var hiTomFile: AKAudioFile?
                var openHiHatFile: AKAudioFile?
                var clapFile: AKAudioFile?
                var metronomeSound1File: AKAudioFile?
                var metronomeSound2File: AKAudioFile?
                let array = [bassDrumFile, clapFile, closedHiHatFile, loTomFile,
                             midTomFile, hiTomFile, openHiHatFile, snareDrumFile,
                             metronomeSound1File, metronomeSound2File]
                return array
    }()

    private let drumFilesPartOne = ["Drums/bass_drum",
                                    "Drums/snare",
                                    "Drums/closed_hi_hat",
                                    "Drums/open_hi_hat",
                                    "Drums/lo_tom",
                                    "Drums/mid_tom",
                                    "Drums/hi_tom",
                                    "Drums/clap",
                                    "Drums/metronomeSound1",
                                    "Drums/metronomeSound2"]

    private let drumFilesPartTwo = ["_C1.wav",
                                    "_D1.wav",
                                    "_F#1.wav",
                                    "_A#1.wav",
                                    "_F1.wav",
                                    "_B1.wav",
                                    "_D2.wav",
                                    "_D#1.wav",
                                    "_C3.wav",
                                    "_C#3.mp3"]

    init() {
        loadDrums()
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

    private func loadDrums() {
        concatenateSampleFilePaths()
        let unwrapedSampleFilePaths = unwrapSampleFilePaths()
        do {
            try sampler.loadAudioFiles(unwrapedSampleFilePaths)
        } catch {
            print("Error while loading drums")
        }
    }

    private func concatenateSampleFilePaths() {
        for index in 0..<sampleFilesArray.count {
            do {
                sampleFilesArray[index] = try AKAudioFile(readFileName: drumFilesPartOne[index]
                    + drumFilesPartTwo[index])
            } catch {
                print("Error while concatenating sample file paths for index: " + String(index))
            }
        }
    }

    private func unwrapSampleFilePaths() -> [AKAudioFile] {
        var unwrapedPaths = [AKAudioFile]()
        for drum in sampleFilesArray {
            if let drumFile = drum { unwrapedPaths.append(drumFile) }
        }
        return unwrapedPaths
    }

    func play(noteTag: Int) {
        let midiNote = midiNotes[noteTag]
        playSample(note: midiNote)
    }

    private func playSample(note: Int) {
        if note == 42 { stopSample(note: 46) }
        do {
            try sampler.play(noteNumber: MIDINoteNumber(note - 12))
        } catch {
            print("Error while playing drums.")
        }
    }

    private func stopSample(note: Int) {
        do {
            try sampler.stop(noteNumber: MIDINoteNumber(note - 12))
        } catch {
            print("Error while playing drums.")
        }
    }

}
