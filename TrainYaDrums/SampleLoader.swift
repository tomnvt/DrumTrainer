//
//  Sample.swift
//  DrumTrainer
//
//  Created by NVT on 24.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AudioKit

class SampleLoader {

    public let sampler: AKAppleSampler

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

    init(sampler: AKAppleSampler) {
        self.sampler = sampler
        loadSamples()
    }

    public func loadSamples() {
        concatenateSampleFilePaths()
        let unwrapedSampleFilePaths = unwrapSampleFilePaths()
        do {
            return try sampler.loadAudioFiles(unwrapedSampleFilePaths)
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

}
