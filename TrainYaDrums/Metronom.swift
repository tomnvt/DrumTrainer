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

class Metronome : Synchronizable {
    
    var metronomeIsRunning : Bool = false
    var delegate: MetronomeButtonFlashDelegate?
    var player : AVAudioPlayer?
    
    override func playSynchronized() {
        guard metronomeIsRunning else {
            return
        }
        if currentBeatIndex == 0 {
            playMetronome(sound: "metronomeSound1")
        } else {
            playMetronome(sound: "metronomeSound2")
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
