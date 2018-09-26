//
//  File.swift
//  DrumTrainer
//
//  Created by NVT on 10.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class ExampleBeatNotes {

    static let realm = try! Realm()

    var firstBarDrumNotes: [[Int]] = []

    static func saveExampleBeatToRealm(beatNotes: [[Int]], beatName: String) -> Bool {
        guard checkThatBeatWithCurrentNameIsNotAlreadySaved(name: beatName) else { return false }
        let oneBeatEighthNotes = OneBeatEighthNotes()
        for indexOne in 0..<beatNotes.count {
            let drumPadEighthNotes = DrumpadEighthNotes()
            for indexTwo in 0..<beatNotes[indexOne].count {
                drumPadEighthNotes.notes.append(beatNotes[indexOne][indexTwo])
            }
            oneBeatEighthNotes.notesList.append(drumPadEighthNotes)
        }
        let simpleHouseExampleBeat = ExampleBeat()
        simpleHouseExampleBeat.oneBeatEighthNotesList.append(oneBeatEighthNotes)
        simpleHouseExampleBeat.name = beatName
        do {
            try realm.write {
                realm.add(simpleHouseExampleBeat)
            }
        } catch {
            print("Realm error: \(error)")
            return false
        }
        return true
    }

    static func checkThatBeatWithCurrentNameIsNotAlreadySaved(name: String) -> Bool {
        let savedBeatsNames = BeatNotesLoader.getBeatNames()
        if savedBeatsNames.contains(name) {
            return false
        }
        return true
    }

}
