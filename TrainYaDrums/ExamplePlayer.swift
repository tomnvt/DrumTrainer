//
//  ExamplePlayer.swift
//  DrumTrainer
//
//  Created by NVT on 22.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation

protocol ExamplePlayerDelegate: AnyObject {
    func playDrum(drumPadIndex: [Int])
}

class ExamplePlayer: Synchronizable {

    var exampleBeat = SimpleBrokenBeatExample()
    var drumExampleIsPlaying: Bool = false
    weak var delegate: ExamplePlayerDelegate?

    override func eighthNoteAction() {
        guard drumExampleIsPlaying else { return }
        for index in 0...15 where exampleBeat.firstBarDrumNotes[index][eighthNoteIndex] == 1 {
            delegate?.playDrum(drumPadIndex: [index])
        }
    }

}
