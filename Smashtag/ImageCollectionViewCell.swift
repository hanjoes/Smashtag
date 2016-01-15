//
//  ImageCollectionViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/15/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!

    var imageURL: NSURL? {
        didSet {
            if imageURL != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        if let url = imageURL {
            spinner.startAnimating()
            dispatch_async(queue) { () -> Void in
                if let imageData = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if url == (self.imageURL)! {
                            if let image = UIImage(data: imageData) {
                                self.imageView.image = image
                            }
                        }
                        self.spinner.stopAnimating()
                    })
                }
            }
        }
    }
}
