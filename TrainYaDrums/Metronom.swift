//
//  Metronom.swift
//  DrumTrainer
//
//  Created by NVT on 09.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AVFoundation

protocol MetronomeButtonFlashDelegate {
    func metronomeButtonFlash()
}

class Metronome {
    
    var timer = Timer()
    var metronomeIsRunning : Bool = false
    var beatIndex : Int = 0
    var beats : [Int] = [1, 2, 3, 4]
    var delegate: MetronomeButtonFlashDelegate?
    
    let beat = Notification.Name(rawValue: "globalClockBeat")
    
    var player : AVAudioPlayer?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(playClick), name: beat, object: nil)
    }
    
    @objc func playClick() {
        guard metronomeIsRunning else {
            return
        }
        beatIndex += 1
        if beatIndex == 1 {
            playMetronome(sound: "metronomeSound1")
        } else {
            playMetronome(sound: "metronomeSound2")
        }
        if beatIndex == 4 {
            beatIndex = 0
        }
        delegate?.metronomeButtonFlash()
    }
    
    @objc func playMetronome(sound : String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
