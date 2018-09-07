//
//  ExamplePlayer.swift
//  DrumTrainer
//
//  Created by NVT on 22.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

protocol ExamplePlayerDelegate: AnyObject {
    func touchDownDrumPad(drumPadIndexes: [Int])
}

class ExamplePlayer: Synchronizable {

    let exampleLibrary = ExampleLibrary()
    var exampleBeat = SimpleBrokenBeatExample()

    var beatExample: ExampleBeat? {
        didSet {
            BeatLoader.getNotesFor(exampleBeatObject: beatExample!, beatIndex: 0, drumPadIndex: 0)
        }
    }
    var drumExampleIsPlaying: Bool = false
    weak var delegate: ExamplePlayerDelegate?

    //- MARK: Add didSet when exampleBeatIsChanged

    override init() {
        super.init()
        exampleBeat = SimpleBrokenBeatExample()
        print(BeatLoader.getNotesFor(exampleBeatName: "Simple House", beatIndex: 0, drumPadIndex: 0))
    }

    override func eighthNoteAction() {
        guard drumExampleIsPlaying else { return }
        for index in 0...15 where exampleBeat.firstBarDrumNotes[index][eighthNoteIndex] == 1 {
            delegate?.touchDownDrumPad(drumPadIndexes: [index])
        }
    }

}
