//
//  ExamplePlayer.swift
//  DrumTrainer
//
//  Created by NVT on 22.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

protocol ExamplePlayerDelegate: AnyObject {
    func playDrum(beatpadNumber: [Int])
}

class ExamplePlayer: Synchronizable {

    var drumExampleIsPlaying = false
    let exampleBeatSequence = [[0], [2], [0, 1], [2], [0], [2], [0, 1], [2]]
    weak var delegate: ExamplePlayerDelegate?

    override func playSynchronized() {
        guard drumExampleIsPlaying else {
            return
        }
        delegate?.playDrum(beatpadNumber: exampleBeatSequence[currentBeatIndex])
    }

}
