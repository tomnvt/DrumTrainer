//
//  SampleLibrary.swift
//  DrumTrainer
//
//  Created by NVT on 31.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AudioKit

class SampleLibrary {

    public let metronomeSamples: [Sample] = [Sample("Drums/metronomeSound1", "_C3.wav"),
                                             Sample("Drums/metronomeSound2", "_C#3.wav")]

    public let drumSamples: [Sample] = [Sample("Drums/bass_drum", "_C1.wav"),
                                        Sample("Drums/snare", "_D1.wav"),
                                        Sample("Drums/closed_hi_hat", "_F#1.wav"),
                                        Sample("Drums/open_hi_hat", "_A#1.wav"),
                                        Sample("Drums/lo_tom", "_F1.wav"),
                                        Sample("Drums/mid_tom", "_B1.wav"),
                                        Sample("Drums/hi_tom", "_D2.wav"),
                                        Sample("Drums/clap", "_D#1.wav")]

}
