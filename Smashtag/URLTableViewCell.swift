//
//  URLTableViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/13/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class URLTableViewCell: UITableViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    
    var urlStr: String? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        if let urlStr = self.urlStr {
            urlLabel.text = urlStr
        }
    }
}
