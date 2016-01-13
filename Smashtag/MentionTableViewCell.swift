//
//  MentionTableViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/13/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class MentionTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    
    var detail: TweetDetail? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let keyword = detail?.detail.keyword {
            infoLabel.text = keyword
        }
    }
}
