//
//  SimpleHouseBeatExample.swift
//  DrumTrainer
//
//  Created by NVT on 10.08.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class SimpleHouseBeatExample: BeatExample {

    let exampleNotes = { () -> [[Int]] in
        var drumPadNotes: [[Int]] = [[]]
        let eighthsArray = [0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0]
        for _ in 0...15 {
            drumPadNotes.append(eighthsArray)
        }
        drumPadNotes[0] = [1, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0]
        drumPadNotes[1] = [0, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0, 0, 0, 0,
                           1, 0, 0, 0, 0, 0, 0, 0]
        drumPadNotes[2] = [0, 0, 0, 0, 1, 0, 0, 0,
                           0, 0, 0, 0, 1, 0, 0, 0,
                           0, 0, 0, 0, 1, 0, 0, 0,
                           0, 0, 0, 0, 1, 0, 0, 0]
        return drumPadNotes
    }()

//    var oneBarEighthNotes: OneBarEighthNotes = { () -> OneBarEighthNotes in
//        var theNotes = OneBarEighthNotes()
//        print("Initializing oneBarEighthNotes")
//        print(theNotes)
//        return theNotes
//    }()

//    var oneBarEighthNotes: OneBarEighthNotes = {
//       var theNotes = OneBarEighthNotes()
//        print(theNotes)
//        return theNotes
//    }()

    

}
