//
//  ImageTableViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/13/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImage: UIImageView!
    

    var urlStr: String? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let urlStr = self.urlStr {
            if let url = NSURL(string: urlStr) {
                if let imageData = NSData(contentsOfURL: url) {
                    mediaImage?.image = UIImage(data: imageData)
                }
            }
        }
    }
}
