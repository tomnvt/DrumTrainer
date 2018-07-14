//
//  UIView+Blink.swift
//  DrumTrainer
//
//  Created by NVT on 14.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

extension UIView{
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
}
