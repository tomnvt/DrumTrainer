//
//  BeatNotesSaver.swift
//  DrumTrainer
//
//  Created by NVT on 09.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class BeatNotesSaver {

    static let realm = try! Realm()
    static let defaults = UserDefaults.standard

    static func save(beatNotes: [[Int]]) {
        let oneBeatEighthNotes = OneBeatEighthNotes()
        for drumPadIndex in 0...15 {
            let currentDrumPadEighthNotes = DrumpadEighthNotes()
            for noteIndex in 0...31 {
                currentDrumPadEighthNotes.notes.append(beatNotes[drumPadIndex][noteIndex])
            }
            oneBeatEighthNotes.notesList.append(currentDrumPadEighthNotes)
        }
        let currentlySelectedBeatName = BeatNotesSaver.defaults.string(forKey: "currentlySelectedBeatName")
        let currentBeat = realm.object(ofType: ExampleBeat.self, forPrimaryKey: currentlySelectedBeatName)
        do {
            try BeatNotesSaver.realm.write {
                if let unwrappedCurrentBeat = currentBeat {
                    for index in 0...15 {
                        unwrappedCurrentBeat.oneBeatEighthNotesList[0].notesList[index]
                            = oneBeatEighthNotes.notesList[index]
                    }
                }
            }
        } catch {
            print("Erorr: \(error)")
        }
    }

}
