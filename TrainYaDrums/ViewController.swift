//
//  ViewController.swift
//  TrainYaDrums
//
//  Created by NVT on 25.06.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let drums = Drums()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drums.loadDrums()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.tag)
    }
    
}

