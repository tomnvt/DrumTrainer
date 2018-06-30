//
//  Drums.swift
//  TrainYaDrums
//
//  Created by NVT on 30.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AudioKit

class Drums {
    
    static let drums = AKAppleSampler()
    
    static var drumFilesArray : [AKAudioFile?] = {
        var bassDrumFile : AKAudioFile?
        var snareDrumFile : AKAudioFile?
        var closedHiHatFile : AKAudioFile?
        var loTomFile : AKAudioFile?
        var midTomFile : AKAudioFile?
        var hiTomFile : AKAudioFile?
        var openHiHatFile : AKAudioFile?
        var clapFile : AKAudioFile?
        let array = [bassDrumFile, clapFile, closedHiHatFile, loTomFile, midTomFile, hiTomFile, openHiHatFile, snareDrumFile]
        return array
    }()
    
    static let drumFilesPartOne = ["Drums/bass_drum",
                            "Drums/snare",
                            "Drums/closed_hi_hat",
                            "Drums/open_hi_hat",
                            "Drums/lo_tom",
                            "Drums/mid_tom",
                            "Drums/hi_tom",
                            "Drums/clap"]
    
    static let drumFilesPartTwo = ["_C1.wav",
                            "_D1.wav",
                            "_F#1.wav",
                            "_A#1.wav",
                            "_F1.wav",
                            "_B1.wav",
                            "_D2.wav",
                            "_D#1.wav"]
    
    static func loadDrums() {
        var drumFiles = [AKAudioFile]()
        for drum in drumFilesArray {
            if let drumFile = drum { drumFiles.append(drumFile) }
        }
        do {
            try drums.loadAudioFiles(drumFiles)
        } catch {
            print("Error while loading drums")
        }
    }
    
}
