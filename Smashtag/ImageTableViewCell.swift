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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var imageItem: MediaItem? {
        didSet {
            updateUI()
        }
    }
    var imageObj: UIImage?
    
    // MARK: - Private
    
    private func updateUI() {
        let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        activityIndicator.startAnimating()
        dispatch_async(queue) { () -> Void in
            if let url = self.imageItem?.url {
                if let imageData = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if url == self.imageItem?.url {
                            self.imageObj = UIImage(data: imageData)
                            self.mediaImage?.image = self.imageObj
                            self.activityIndicator?.stopAnimating()
                        }
                    })
                }
            }
        }
    }
}
