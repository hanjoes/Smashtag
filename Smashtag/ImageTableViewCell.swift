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
    

    var imageItem: MediaItem? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if let imageData = NSData(contentsOfURL: (imageItem?.url)!) {
            mediaImage?.image = UIImage(data: imageData)
        }
    }
}
