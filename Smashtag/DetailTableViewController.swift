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
        static let MentionReuseIdentifier = "Mention"
        static let URLReuseIdentifier = "URL"
    }
    
    private enum TweetDetail {
        case Media(image: MediaItem)
        case URLMention(url: Tweet.IndexedKeyword)
        case UserMention(user: Tweet.IndexedKeyword)
        case HashTag(hashTag: Tweet.IndexedKeyword)
        
        var detail: (desc: String, content: String, identifier: String) {
            switch self {
            case .Media(let image):
                return ("Media", image.url.description, Detail.MediaReuseIdentifier)
            case .URLMention(let url):
                return ("URLs", url.keyword, Detail.URLReuseIdentifier)
            case .UserMention(let user):
                return ("Users", user.keyword, Detail.MentionReuseIdentifier)
            case .HashTag(let hashTag):
                return ("Hash Tags", hashTag.keyword, Detail.MentionReuseIdentifier)
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(self.tableView, cellForRowAtIndexPath: indexPath)
        if let urlCell = cell as? URLTableViewCell {
            if let url = NSURL(string: urlCell.urlStr!) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let detail = details[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(detail.detail.identifier, forIndexPath: indexPath)

        // Configure the cell...
        if let infoCell = cell as? MentionTableViewCell {
            infoCell.info = detail.detail.content
        }
        else if let imageCell = cell as? ImageTableViewCell {
            imageCell.urlStr = detail.detail.content
        }
        else if let urlCell = cell as? URLTableViewCell {
            urlCell.urlStr = detail.detail.content
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return details[section][0].detail.desc
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? TweetTableViewController {
            if let cell = sender as? MentionTableViewCell {
                destination.searchText = cell.info
            }
        }
    }

}
