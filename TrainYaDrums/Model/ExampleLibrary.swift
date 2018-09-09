//
//  ExampleLibrary.swift
//  DrumTrainer
//
//  Created by NVT on 05.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class ExampleLibrary {

    let realm = try! Realm()
    var currentLoadedBeatIndex: Int = 0

    var exampleBeats: [ExampleBeatNotes] = {
        var array: [ExampleBeatNotes] = []
        let simpleBrokenBeatExample = SimpleBrokenBeatExampleBeat()
        let simpleHouseExampleBeat = SimpleHouseExampleBeat()
        array.append(simpleBrokenBeatExample)
        array.append(simpleHouseExampleBeat)
        return array
    }()

}
