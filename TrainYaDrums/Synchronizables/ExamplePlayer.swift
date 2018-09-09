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
//    var exampleBeat: ExampleBeatNotes
    var exampleBeatNotes: [[Int]] = []
    var currentLoaddedBeatIndex: Int = 0
    let defaults = UserDefaults.standard

    var drumExampleIsPlaying: Bool = false
    weak var delegate: ExamplePlayerDelegate?

    override init() {
//        exampleBeat = BeatNotesLoader.getNotesFor(exampleIndex: 0, beatIndex: 0)
        let currentlySelectedBeatIndex = defaults.integer(forKey: "currentlySelectedBeat")
        exampleBeatNotes = BeatNotesLoader.getNotesFor(exampleIndex: currentlySelectedBeatIndex, beatIndex: 0)
        super.init()
    }

    override func eighthNoteAction() {
        guard drumExampleIsPlaying else { return }
        for index in 0...15 where exampleBeatNotes[index][eighthNoteIndex] == 1 {
            delegate?.touchDownDrumPad(drumPadIndexes: [index])
        }
    }

    func loadExamplebeat(beatExampleIndex: Int) {
        exampleBeatNotes = BeatNotesLoader.getNotesFor(exampleIndex: beatExampleIndex, beatIndex: 0)
    }

}
