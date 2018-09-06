//
//  ExampleBeat.swift
//  DrumTrainer
//
//  Created by NVT on 06.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class ExampleBeat: Object {

    @objc dynamic var name: String = ""
    let oneBeatEighthNotesList = List<OneBeatEighthNotes>()

    override static func primaryKey() -> String {
        return "name"
    }

}
