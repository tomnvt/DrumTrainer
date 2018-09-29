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
        blink(fromColor: UIColor(rgb: 0xFFFECD), toColor: .yellow, delay: 0.0)
    }

    func orangeBlink() {
        blink(fromColor: UIColor(rgb: 0xFFFECD), toColor: UIColor(rgb: 0xFFE254), delay: 0.0)
    }

    func orangeBlinkWithTwoSecondsDelay() {
        blink(fromColor: .yellow, toColor: UIColor.clear, delay: 1.0)
    }

    func blackToYellowBlink() {
        blink(fromColor: UIColor(rgb: 0x000000), toColor: .yellow, delay: 0.0)
    }

    func blink(fromColor: UIColor, toColor: UIColor, delay: Float) {
        self.backgroundColor = fromColor
        UIView.animate(withDuration: 0.3, delay: TimeInterval(delay), options: [.allowUserInteraction, .curveLinear],
                       animations: {self.backgroundColor = toColor}, completion: nil)
    }

}
