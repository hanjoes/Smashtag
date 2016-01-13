//
//  DetailTableViewController.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/6/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    private struct Detail {
        static let MediaReuseIdentifier = "Media"
        static let InfoReuseIdentifier = "Info"
    }
    
    private enum TweetDetail {
        case Media(image: MediaItem)
        case URLMention(url: Tweet.IndexedKeyword)
        case UserMention(user: Tweet.IndexedKeyword)
        case HashTag(hashTag: Tweet.IndexedKeyword)
        
        var description: String {
            switch self {
            case .Media(_):
                return "Media"
            case .URLMention(_):
                return "URLs"
            case .UserMention(_):
                return "Users"
            case .HashTag(_):
                return "Hash Tags"
            }
        }
        
        var detail: String {
            switch self {
            case .Media(let image):
                return image.url.description
            case .URLMention(let url):
                return url.keyword
            case .UserMention(let user):
                return user.keyword
            case .HashTag(let hashTag):
                return hashTag.keyword
            }
        }
        
        var identifier: String {
            switch self {
            case .Media(_):
                return Detail.MediaReuseIdentifier
            case .URLMention(_):
                return Detail.InfoReuseIdentifier
            case .UserMention(_):
                return Detail.InfoReuseIdentifier
            case .HashTag(_):
                return Detail.InfoReuseIdentifier
            }
        }
    }

    // MARK: - Model
    var tweet: Tweet? {
        didSet {
            if tweet != nil {
                initializeDetails(tweet!)
                tableView.reloadData()
            }
        }
    }
    
    private var details = [[TweetDetail]]()
    
    private func initializeDetails(tweet: Tweet) {
        if tweet.media.count > 0 {
            details.append(tweet.media.map{ .Media(image: $0) })
        }
        if tweet.urls.count > 0 {
            details.append(tweet.urls.map{ .URLMention(url: $0) })
        }
        if tweet.userMentions.count > 0 {
            details.append(tweet.userMentions.map{ .UserMention(user: $0) })
        }
        if tweet.hashtags.count > 0 {
            details.append(tweet.hashtags.map{ .HashTag(hashTag: $0) })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return details.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return details[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let detail = details[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(detail.identifier, forIndexPath: indexPath)

        // Configure the cell...
        if let infoCell = cell as? InfoTableViewCell {
            infoCell.info = detail.detail
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return details[section][0].description
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
