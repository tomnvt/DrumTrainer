//
//  PathCollectionViewCell.swift
//  DrumTrainer
//
//  Created by NVT on 08.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

public class PathCollectionViewCell: UICollectionViewCell {

    public static let identifier: String = "PCVCRI"

    @IBOutlet var textLabel: UILabel!

    public func setIndexPath(_ indexPath: IndexPath) {
        self.textLabel.text = ""
    }

}
