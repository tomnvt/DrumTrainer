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
    
    var player : AVAudioPlayer?
    
    func runMetronomeWith(BPM: Float) {
        beatIndex = 0
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1/(BPM/60)),
                                     target: self, selector: #selector(self.playClick),
                                     userInfo: nil, repeats: true)
        metronomeIsRunning = true
    }
    
    func stopMetronome() {
        timer.invalidate()
        metronomeIsRunning = false
    }
    
    func changeMetronomeSpeed(toBPM: Float) {
        stopMetronome()
        runMetronomeWith(BPM: toBPM)
    }
    
    @objc func playClick() {
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
    
    func playMetronome(sound : String) {
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
