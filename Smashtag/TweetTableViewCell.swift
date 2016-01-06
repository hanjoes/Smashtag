//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/5/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
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
                if let attributedString = tweetTextLabel?.attributedText {
                    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
                    for url in tweet.urls {
                        if let nsrange = url.nsrange {
                            mutableAttributedString.addAttribute(NSForegroundColorAttributeName,
                                value: UIColor.blueColor(),
                                range: nsrange)
                            mutableAttributedString.addAttribute(NSUnderlineStyleAttributeName,
                                value: NSUnderlineStyle.StyleSingle.rawValue,
                                range: nsrange)
                            tweetTextLabel.attributedText = mutableAttributedString
                        }
                    }
                    for hash in tweet.hashtags {
                        if let nsrange = hash.nsrange {
                            mutableAttributedString.addAttribute(NSForegroundColorAttributeName,
                                value: UIColor.blueColor(),
                                range: nsrange)
                            mutableAttributedString.addAttribute(NSFontAttributeName,
                                value: UIFont.boldSystemFontOfSize(tweetTextLabel.font.pointSize),
                                range: nsrange)
                            tweetTextLabel.attributedText = mutableAttributedString
                        }
                    }
                    for mention in tweet.userMentions {
                        if let nsrange = mention.nsrange {
                            mutableAttributedString.addAttribute(NSForegroundColorAttributeName,
                                value: UIColor.blueColor(),
                                range: nsrange)
                            tweetTextLabel.attributedText = mutableAttributedString
                        }
                    }
                }
                
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
            
//            let formatter = NSDateFormatter()
//            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
//                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            }
//            else {
//                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            }
//            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
}
