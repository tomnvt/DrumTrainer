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
    var exampleBeat: ExampleBeatNotes

    var beatExample: ExampleBeat? {
        didSet {
            BeatNotesLoader.getNotesFor(exampleBeatObject: beatExample!, beatIndex: 0, drumPadIndex: 0)
        }
    }
    var drumExampleIsPlaying: Bool = false
    weak var delegate: ExamplePlayerDelegate?

    //- MARK: Add didSet when exampleBeatIsChanged

    override init() {
        exampleBeat = exampleLibrary.exampleBeats[0]
        print(BeatNotesLoader.getNotesFor(exampleBeatName: "Simple House", beatIndex: 0))
        dump(BeatNotesLoader.getNotesFor(exampleBeatName: "Simple House", beatIndex: 0))
        super.init()
    }

    override func eighthNoteAction() {
        guard drumExampleIsPlaying else { return }
        for index in 0...15 where exampleBeat.firstBarDrumNotes[index][eighthNoteIndex] == 1 {
            delegate?.touchDownDrumPad(drumPadIndexes: [index])
        }
    }

}
