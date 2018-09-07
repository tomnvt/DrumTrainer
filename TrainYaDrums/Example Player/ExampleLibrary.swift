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
    let simpleBrokenBeatExample = SimpleBrokenBeatExample()
    let simpleHouseExampleBeat = SimpleHouseExampleBeat()
    var exampleBeats = [SimpleHouseBeatExample()]
}
