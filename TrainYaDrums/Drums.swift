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
    
    let drums = AKAppleSampler()
    
    var drumFilesArray : [AKAudioFile?] = {
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
    
    let drumFilesPartOne = ["Drums/bass_drum",
                            "Drums/snare",
                            "Drums/closed_hi_hat",
                            "Drums/open_hi_hat",
                            "Drums/lo_tom",
                            "Drums/mid_tom",
                            "Drums/hi_tom",
                            "Drums/clap"]
    
    let drumFilesPartTwo = ["_C1.wav",
                            "_D1.wav",
                            "_F#1.wav",
                            "_A#1.wav",
                            "_F1.wav",
                            "_B1.wav",
                            "_D2.wav",
                            "_D#1.wav"]

    func loadDrums() {
        for index in 0..<drumFilesArray.count {
            do {
                drumFilesArray[index] = try AKAudioFile(readFileName: drumFilesPartOne[index] + "" + drumFilesPartTwo[index])
            }
            catch {
                print("Error while setting drum paths")
            }
        }
        
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
    
    func play(note_tag: Int) {
        switch note_tag {
        case 0:
            playDrum(note: 36)
        case 1:
            playDrum(note: 38)
        case 2:
            stopDrum(note: 46)
            playDrum(note: 42)
        case 3:
            playDrum(note: 46)
        case 4:
            playDrum(note: 47)
        case 5:
            playDrum(note: 41)
        case 38:
            playDrum(note: 50)
        case 40:
            playDrum(note: 39)
        default:
            break
        }
    }
    
    func playDrum(note: Int) {
        do {
            print(String(note) + " played")
            try drums.play(noteNumber: MIDINoteNumber(note))
        }
        catch {
            print("Error while playing drums.")
        }
    }
    
    func stopDrum(note: Int) {
        do {
            try drums.stop(noteNumber: MIDINoteNumber(note - 12))
        }
        catch {
            print("Error while playing drums.")
        }
    }
}
