//
//  Metronom.swift
//  DrumTrainer
//
//  Created by NVT on 09.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import Foundation
import AVFoundation
import AudioKit

protocol MetronomeButtonFlashDelegate: AnyObject {
    func metronomeButtonFlash()
}

class Metronome: Synchronizable {

    var metronomeIsRunning: Bool = false
    var playerVolume: Float = 0.8
    weak var delegate: MetronomeButtonFlashDelegate?
    var player: AVAudioPlayer?
    var metronomeSounds = ["metronomeSound1.wav",
                           "metronomeSound2.wav"]
    var firstMetronomeSoundAudioPlayer: AKAudioPlayer?
    var secondMetronomeSoundAudioPlayer: AKAudioPlayer?
    var audioMixer = AKMixer()

    override init() {
        super.init()
        loadMetronomeSounds()
        connectMetronomeSoundPlayersToMixer()
        startAudioKit()
    }

    
    func loadMetronomeSounds() {
        do {
            let firstMetronomeSoundAudioFile = try AKAudioFile(readFileName: metronomeSounds[0])
            let secondMetronomeSoundAudioFile = try AKAudioFile(readFileName: metronomeSounds[1])
            firstMetronomeSoundAudioPlayer = try AKAudioPlayer(file: firstMetronomeSoundAudioFile)
            secondMetronomeSoundAudioPlayer = try AKAudioPlayer(file: secondMetronomeSoundAudioFile)
        } catch {
            print("ERROR: Metronome sound file is missing")
        }
    }

    fileprivate func startAudioKit() {
        AudioKit.output = audioMixer
        do {
            try AudioKit.start()
        } catch {
            print("ERROR: AudioKit failed to start")
        }
    }

    fileprivate func connectMetronomeSoundPlayersToMixer() {
        audioMixer.connect(input: firstMetronomeSoundAudioPlayer)
        audioMixer.connect(input: secondMetronomeSoundAudioPlayer)
    }

    override func playSynchronized() {
        guard metronomeIsRunning else {
            return
        }
        if currentBeatIndex == 0 {
            firstMetronomeSoundAudioPlayer?.play()
        } else {
            secondMetronomeSoundAudioPlayer?.play()
        }
        delegate?.metronomeButtonFlash()
    }

    //- MARK: Add independent Player class
    //- MARK: Change AVAudioPlayer to AudioKit routing
    @objc func playMetronome(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            player?.setVolume(playerVolume, fadeDuration: 0.0)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}
