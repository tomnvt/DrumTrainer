//
//  UIView+@IBInspectable.swift
//  DrumTrainer
//
//  Created by NVT on 14.07.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}
