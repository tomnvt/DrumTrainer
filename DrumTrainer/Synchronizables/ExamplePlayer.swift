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

class ExamplePlayer: Synchronizable, BeatNotesSaverDelegate {

    let exampleLibrary = ExampleLibrary()
    static var exampleBeatNotes: [[Int]] = []
    var currentLoaddedBeatIndex: Int = 0
    let defaults = UserDefaults.standard
    let realm = try! Realm()

    var drumExampleIsPlaying: Bool = false
    weak var delegate: ExamplePlayerDelegate?

    override init() {
        let currentlySelectedBeatName = defaults.string(forKey: "currentlySelectedBeatName")
        if currentlySelectedBeatName == nil {
            ExamplePlayer.exampleBeatNotes = BeatNotesLoader
                .getNotesFor(exampleIndex: 0, beatIndex: 0)
        } else {
            ExamplePlayer.exampleBeatNotes = BeatNotesLoader
                .getNotesFor(exampleBeatName: currentlySelectedBeatName!, beatIndex: 0)
        }
        super.init()
    }

    override func eighthNoteAction() {
        guard drumExampleIsPlaying else { return }
        for index in 0...15 where ExamplePlayer.exampleBeatNotes[index][eighthNoteIndex] == 1 {
            delegate?.touchDownDrumPad(drumPadIndexes: [index])
        }
    }

    func loadExamplebeat(beatExampleIndex: Int) {
        ExamplePlayer.exampleBeatNotes = BeatNotesLoader.getNotesFor(exampleIndex: beatExampleIndex, beatIndex: 0)
    }

    func saveBeatNotes() {
        let beatNotesSaver = BeatNotesSaver()
        beatNotesSaver.save(beatNotes: ExamplePlayer.exampleBeatNotes)
    }

    static func reloadBeatNotes(beatName: String) {
        ExamplePlayer.exampleBeatNotes = BeatNotesLoader
            .getNotesFor(exampleBeatName: beatName, beatIndex: 0)
    }

}
