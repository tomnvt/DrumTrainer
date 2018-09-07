//
//  SimpleHouseExampleBeat.swift
//  DrumTrainer
//
//  Created by NVT on 06.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class SimpleHouseExampleBeat {

    let realm = try! Realm()

    let drumPadNotes = [[1, 0, 0, 0, 0, 0, 0, 0,    // 0
                         1, 0, 0, 0, 0, 0, 0, 0,
                         1, 0, 0, 0, 0, 0, 0, 0,
                         1, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 1
                         1, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         1, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 1, 0, 0, 0,    // 2
                         0, 0, 0, 0, 1, 0, 0, 0,
                         0, 0, 0, 0, 1, 0, 0, 0,
                         0, 0, 0, 0, 1, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 3
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 4
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 5
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 6
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 7
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [1, 0, 0, 0, 0, 0, 0, 0,    // 8
                         1, 0, 0, 0, 0, 0, 0, 0,
                         1, 0, 0, 0, 0, 0, 0, 0,
                         1, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 9
                         1, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         1, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 1, 0, 0, 0,    // 10
                         0, 0, 0, 0, 1, 0, 0, 0,
                         0, 0, 0, 0, 1, 0, 0, 0,
                         0, 0, 0, 0, 1, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 11
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 12
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 13
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 14
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0, 0, 0, 0,    // 15
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0]]

    init() {
        let oneBeatEighthNotes = OneBeatEighthNotes()
        for indexOne in 0..<drumPadNotes.count {
            let drumPadEighthNotes = DrumpadEighthNotes()
            for indexTwo in 0..<drumPadNotes[indexOne].count {
                drumPadEighthNotes.notes.append(drumPadNotes[indexOne][indexTwo])
            }
            oneBeatEighthNotes.notesList.append(drumPadEighthNotes)
        }
        let simpleHouseExampleBeat = ExampleBeat()
        simpleHouseExampleBeat.oneBeatEighthNotesList.append(oneBeatEighthNotes)
        simpleHouseExampleBeat.name = "Simple House"
        do {
            try realm.write {
                realm.deleteAll()
                realm.add(simpleHouseExampleBeat)
            }
        } catch {
            print("Realm error: \(error)")
        }
    }

}
