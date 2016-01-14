//
//  ImageViewController.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/14/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 2
        }
    }
    
    // MARK: - Public API
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        // Do any additional setup after loading the view.
    }

    // MARK: - Private
    
    private var imageView = UIImageView()

    // MARK: - Delegate For ScrollView
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
