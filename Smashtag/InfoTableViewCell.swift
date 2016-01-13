//
//  InfoTableViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/13/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    
    var info: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let info = self.info {
            infoLabel.text = info
        }
    }
}
