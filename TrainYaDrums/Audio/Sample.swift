//
//  Sample.swift
//  DrumTrainer
//
//  Created by NVT on 31.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AudioKit

class Sample {

    var audioFile: AKAudioFile?
    var filePathPartOne: String
    var filePathPartTwo: String

    init(_ filePathPartOne: String, _ filePathPartTwo: String) {
        self.filePathPartOne = filePathPartOne
        self.filePathPartTwo = filePathPartTwo
        self.audioFile = loadSampleAudioFile()
    }

    func loadSampleAudioFile() -> AKAudioFile? {
        var sample: AKAudioFile?
        let filePath = filePathPartOne + filePathPartTwo
        do {
            try sample = AKAudioFile(readFileName: filePath)
        } catch {
            print("Error while loading audio file from file path: " + filePath)
        }
        return sample
    }

}
