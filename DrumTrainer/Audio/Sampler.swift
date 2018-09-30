//
//  Sampler.swift
//  DrumTrainer
//
//  Created by NVT on 01.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AudioKit

class Sampler: AKAppleSampler {

    let sampleLoader = SampleLoader()
    var samples: [Sample]

    init(samples: [Sample]) {
        self.samples = samples
        super.init()
        loadSamples()
    }

    func loadSamples() {
        sampleLoader.loadSamples(sampler: self, samples: samples)
    }

}
