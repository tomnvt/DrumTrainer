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

    private let sampleLibrary = SampleLibrary()

    public func loadSamples(sampler: AKAppleSampler, samples: [Sample]) {
        var audioFiles = [AKAudioFile]()
        for sample in samples {
            guard let audioFile = sample.audioFile else { continue }
            audioFiles.append(audioFile)
        }
        do {
            try sampler.loadAudioFiles(audioFiles)
        } catch {
            print("Error while loading drums: \(error)")
        }
    }

}
