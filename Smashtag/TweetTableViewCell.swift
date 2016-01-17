//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/5/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
//        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                // highlight mentions
                let mutableAttributedString = NSMutableAttributedString(attributedString: tweetTextLabel.attributedText!)
                
                let attributesForUrl = [NSForegroundColorAttributeName: UIColor.darkGrayColor(),
                    NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
                let _ = tweet.urls.map({ (kw) -> Void in
                    mutableAttributedString.addAttributes(attributesForUrl, range: kw.nsrange!)
                })
                let attributesForHashTags = [NSForegroundColorAttributeName: UIColor.blueColor(),
                    NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
                let _ = tweet.hashtags.map({ (kw) -> Void in
                    mutableAttributedString.addAttributes(attributesForHashTags, range: kw.nsrange!)
                })
                let attributesForMentions = [NSForegroundColorAttributeName: UIColor.orangeColor()]
                let _ = tweet.userMentions.map({ (kw) -> Void in
                    mutableAttributedString.addAttributes(attributesForMentions, range: kw.nsrange!)
                })
                tweetTextLabel.attributedText = mutableAttributedString
                
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    // blocks main thread!!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            }
            else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetTimeLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
}
