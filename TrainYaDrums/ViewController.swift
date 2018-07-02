//
//  ViewController.swift
//  TrainYaDrums
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    let drums = Drums()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drums.loadDrums()
        
        AudioKit.output = drums.drums
        
        do {
            try AudioKit.start()
        } catch {
            print("Error while starting AudioKit.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.tag)
        drums.play(note_tag: sender.tag)
    }
    
}

