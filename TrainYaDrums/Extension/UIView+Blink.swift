//
//  UIView+Blink.swift
//  DrumTrainer
//
//  Created by NVT on 14.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

extension UIView {
    func yellowBlink() {
        blink(fromColor: UIColor(rgb: 0xFFFECD), toColor: .yellow)
    }

    func orangeBlink() {
        blink(fromColor: UIColor(rgb: 0xFFFECD), toColor: UIColor(rgb: 0xFFE254))
    }

    func blink(fromColor: UIColor, toColor: UIColor) {
        self.backgroundColor = fromColor
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction, .curveLinear],
                       animations: {self.backgroundColor = toColor}, completion: nil)
    }
}
