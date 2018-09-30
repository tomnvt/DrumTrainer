//
//  SamplerFactory.swift
//  DrumTrainer
//
//  Created by NVT on 02.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

class SamplerFactory {

    func makesSamplerOf(sampleType: SampleType) -> Sampler {
        let sampleLibrary = SampleLibrary()
        switch sampleType {
        case .metronome:
            return Sampler(samples: sampleLibrary.metronomeSamples)
        case .drums:
            return Sampler(samples: sampleLibrary.drumSamples)
        }
    }

}
