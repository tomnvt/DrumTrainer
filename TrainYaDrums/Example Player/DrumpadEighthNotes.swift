//
//  DrumpadEighthNotes.swift
//  DrumTrainer
//
//  Created by NVT on 05.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import RealmSwift

class DrumpadEighthNotes: Object {

    var notes: List<Int> = {
        var theNotes = List<Int>()
        for index in 0...32 {
            theNotes.append(0)
        }
        return theNotes
    }()

}
