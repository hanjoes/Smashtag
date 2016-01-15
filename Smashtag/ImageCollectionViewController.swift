//
//  ImageCollectionViewController.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/15/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var imageURLs = [NSURL]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.reloadData()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.reloadData()
    }
    
    // MARK: - Delegate Methods
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        if let ic = cell as? ImageCollectionViewCell {
            ic.imageURL = imageURLs[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let ic = cell as? ImageCollectionViewCell {
            ic.imageView.image = nil
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        let itemHeight = Constants.ItemHeight
        let itemWidth = frameSize.width - 10
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK: - Private
    private struct Constants {
        static let ItemHeight: CGFloat = 150
    }
}
