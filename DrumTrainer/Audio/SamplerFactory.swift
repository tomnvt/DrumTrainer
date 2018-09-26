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
        switch sampleType {
        case .metronome:
            return MetronomeSampler()
        case .drums:
            return DrumSampler()
        }
    }

}
