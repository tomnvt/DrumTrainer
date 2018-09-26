//
//  CollectionReusableView.swift
//  DrumTrainer
//
//  Created by NVT on 08.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

public class CollectionReusableView: UICollectionReusableView {

    @IBOutlet var textLabel: UILabel!

    public static let identifier = "CRVRI"

    public func setIndexPath(_ indexPath: IndexPath, kind: String) {
        self.textLabel.text = "\(indexPath.section + 1)\n/\n4"
    }

}
