//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/14/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

private struct Constants {
    static let defaultMinimumZoomScale: CGFloat = 0.5
    static let defaultMaximumZoomScale: CGFloat = 2.5
}

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = Constants.defaultMinimumZoomScale
            scrollView.maximumZoomScale = Constants.defaultMaximumZoomScale
        }
    }
    
    // MARK: - Public API
    
    var image: UIImage? {
        didSet {
            if image != nil {
                imageView.image = image
                imageView.sizeToFit()
                scrollView?.contentSize = imageView.frame.size
                
                autoZoom()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        autoZoom()
        // Do any additional setup after loading the view.
    }

    // MARK: - Private
    
    private var imageView = UIImageView()
    
    private func autoZoom() {
        let rectSize = view.bounds.size
        let heightRatio = rectSize.height / image!.size.height
        let widthRatio = rectSize.width / image!.size.width
        
        var ratio: CGFloat = 1
        if heightRatio >= 1 || widthRatio >= 1 {
            ratio = widthRatio > heightRatio ? widthRatio : heightRatio
        }
        scrollView.setZoomScale(ratio, animated: true)
    }
    

    // MARK: - Delegate For ScrollView
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
