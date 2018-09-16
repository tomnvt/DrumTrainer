//
//  BeatLoader.swift
//  DrumTrainer
//
//  Created by NVT on 06.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class BeatNotesLoader {

    static let realm = try! Realm()

    static func getNotesFor(exampleBeatName: String, beatIndex: Int) -> [[Int]] {
        let theObject = realm.object(ofType: ExampleBeat.self, forPrimaryKey: exampleBeatName)
        let oneBeatEighthNotesList = Array(theObject!.oneBeatEighthNotesList)[beatIndex].notesList
        var notesArray: [[Int]] = []
        for index in 0...15 {
            notesArray.append(Array(Array(oneBeatEighthNotesList)[index].notes))
        }
        return notesArray
    }

    static func getNotesFor(exampleIndex: Int, beatIndex: Int) -> [[Int]] {
        let theObject = realm.objects(ExampleBeat.self)[exampleIndex]
        let oneBeatEighthNotesList = Array(theObject.oneBeatEighthNotesList)[beatIndex].notesList
        var notesArray: [[Int]] = []
        for index in 0...15 {
            notesArray.append(Array(Array(oneBeatEighthNotesList)[index].notes))
        }
        return notesArray
    }

    static func getNotesFor(exampleBeatName: String, beatIndex: Int, drumPadIndex: Int) -> [Int] {
        let theObject = realm.object(ofType: ExampleBeat.self, forPrimaryKey: exampleBeatName)
        let oneBeatEighthNotesList = Array(theObject!.oneBeatEighthNotesList)[beatIndex].notesList
        let drumPadEighthNotes = Array(Array(oneBeatEighthNotesList)[drumPadIndex].notes)
        return drumPadEighthNotes
    }

    static func getNotesFor(exampleBeatObject: ExampleBeat, beatIndex: Int, drumPadIndex: Int) -> [Int] {
        let oneBeatEighthNotesList = Array(exampleBeatObject.oneBeatEighthNotesList)[beatIndex].notesList
        let drumPadEighthNotes = Array(Array(oneBeatEighthNotesList)[drumPadIndex].notes)
        return drumPadEighthNotes
    }

    static func setNotesFor(exampleBeatName: String, beatIndex: Int, drumPadIndex: Int, eighthNotes: [Int]) {
        var notes = getNotesFor(exampleBeatName: exampleBeatName, beatIndex: beatIndex, drumPadIndex: drumPadIndex)
        for index in 0..<eighthNotes.count {
            notes[index] = eighthNotes[index]
        }
    }

    static func setNotesFor(exampleBeatObject: ExampleBeat, beatIndex: Int, drumPadIndex: Int, eighthNotes: [Int]) {
        var notes = getNotesFor(exampleBeatObject: exampleBeatObject, beatIndex: beatIndex, drumPadIndex: drumPadIndex)
        for index in 0..<eighthNotes.count {
            notes[index] = eighthNotes[index]
        }
    }

    static func getIndexOfCurrentlySelectedBeat() -> Int {
        let defaults = UserDefaults.standard
        let currentlySelectedBeatName = defaults.string(forKey: "currentlySelectedBeatName")
        let currentlySelectedBeat = realm.object(ofType: ExampleBeat.self, forPrimaryKey: currentlySelectedBeatName)
        let allBeats = realm.objects(ExampleBeat.self)
        let indexOfCurrentlySelectedBeat = allBeats.index(of: currentlySelectedBeat!)
        return indexOfCurrentlySelectedBeat!
    }

    static func getBeatNames() -> [String] {
        let savedBeats = realm.objects(ExampleBeat.self)
        var names: [String] = []
        for savedBeat in savedBeats {
            names.append(savedBeat.name)
        }
        return names
    }

}
