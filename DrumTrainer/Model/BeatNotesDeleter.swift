//
//  BeatNotesDeleter.swift
//  DrumTrainer
//
//  Created by NVT on 03/10/2018.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class BeatNotesDeleter {
    
    static let realm = try! Realm()
    
    static func deleteExampleBeat(name: String) {
        let objectToBeDeleted = BeatNotesDeleter.realm.object(ofType: ExampleBeat.self, forPrimaryKey: name)
        guard let object = objectToBeDeleted else { return }
        do {
            try BeatNotesDeleter.realm.write {
                BeatNotesDeleter.realm.delete(object)
            }
        } catch {
            print("Error while deleting beat example with name: " + name)
        }
    }
    
}
