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
        case Media(title: String, images: MediaItem)
        case URLMention(title: String, url: Tweet.IndexedKeyword)
        case UserMention(title: String, user: Tweet.IndexedKeyword)
        case HashTag(title: String, hashTag: Tweet.IndexedKeyword)
        
        func description() -> String {
            switch self {
            case .Media(let title, _):
                return title
            case .URLMention(let title, _):
                return title
            case .UserMention(let title, _):
                return title
            case .HashTag(let title, _):
                return title
            }
        }
        
        func identifier() -> String {
            switch self {
            case .Media(_, _):
                return Detail.MediaReuseIdentifier
            case .URLMention(_, _):
                return Detail.InfoReuseIdentifier
            case .UserMention(_, _):
                return Detail.InfoReuseIdentifier
            case .HashTag(_, _):
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
            details.append(tweet.media.map{ .Media(title: "Media", images: $0) })
        }
        if tweet.urls.count > 0 {
            details.append(tweet.urls.map{ .URLMention(title: "URLs", url: $0) })
        }
        if tweet.userMentions.count > 0 {
            details.append(tweet.userMentions.map{ .UserMention(title: "Mentioned Users", user: $0) })
        }
        if tweet.hashtags.count > 0 {
            details.append(tweet.hashtags.map{ .HashTag(title: "Hashtags", hashTag: $0) })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("section num: \(details.count)")
        return details.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("row num for section \(section): \(details[section].count)")
        return details[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let detail = details[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(detail.identifier(), forIndexPath: indexPath)

        // Configure the cell...

        return cell
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
