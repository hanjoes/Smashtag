//
//  DetailTableViewController.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/6/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    // MARK: - Model
    var tweet: Tweet? {
        didSet {
            if tweet != nil {
                initializeDetails(tweet!)
                tableView.reloadData()
            }
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
        return details.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return details[section].count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch details[indexPath.section][indexPath.row] {
        case .URLMention(let url):
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        case .Media(_):
            performSegueWithIdentifier(TableViewControllerConstants.ShowImageSegueIdentifier, sender: imageCell)
        default: break
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let detail = details[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(detail.detail.identifier, forIndexPath: indexPath)
        // Configure the cell...
        if let mentionCell = cell as? MentionTableViewCell {
            mentionCell.detail = detail
        }
        else if let imageCell = cell as? ImageTableViewCell {
            self.imageCell = imageCell
            imageCell.imageItem = detail.imageItem
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let detail = details[indexPath.section][indexPath.row]
        switch detail {
        case .Media(let image):
            return view.frame.width / CGFloat(image.aspectRatio)
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleBySectionIndex[section]
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.reloadData()
        if let cell = imageCell {
            if fromInterfaceOrientation.isPortrait {
                performSegueWithIdentifier(TableViewControllerConstants.ShowImageSegueIdentifier, sender: cell)
            }
        }
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
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        
        if let ttvc = destination as? TweetTableViewController {
            if let cell = sender as? MentionTableViewCell {
                guard cell.detail!.url == nil else { return }
                ttvc.searchText = cell.detail!.detail.keyword
            }
        }
        else if let ivc = destination as? ImageViewController {
            if let cell = sender as? ImageTableViewCell {
                if let image = cell.imageObj {
                    ivc.image = image
                }
            }
        }
    }
    
    
    // MARK: - Private
    
    private var titleBySectionIndex = [Int:String]()
    
    private var details = [[TweetDetail]]()
    
    private var imageCell: ImageTableViewCell?
    
    private func initializeDetails(tweet: Tweet) {
        if tweet.media.count > 0 {
            details.append(tweet.media.map{ .Media(image: $0) })
            titleBySectionIndex[details.count-1] = "Media"
        }
        if tweet.urls.count > 0 {
            details.append(tweet.urls.map{ .URLMention(url: $0.keyword) })
            titleBySectionIndex[details.count-1] = "URLs"
        }
        
        // dealing with the user who posted the tweet.
        let user = tweet.user
        details.append([.UserMention(user: "@\(user.screenName)")])
        titleBySectionIndex[details.count-1] = "Users"
        if tweet.userMentions.count > 0 {
            details[details.count-1] += tweet.userMentions.map{ .UserMention(user: $0.keyword) }
        }
        
        if tweet.hashtags.count > 0 {
            details.append(tweet.hashtags.map{ .HashTag(hashTag: $0.keyword) })
            titleBySectionIndex[details.count-1] = "Hash Tag"
        }
    }
}

private struct TableViewControllerConstants {
    static let MediaReuseIdentifier = "Media"
    static let MentionReuseIdentifier = "Mention"
    static let ShowImageSegueIdentifier = "ShowImage"
}


enum TweetDetail {
    case Media(image: MediaItem)
    case URLMention(url: String)
    case UserMention(user: String)
    case HashTag(hashTag: String)
    
    var height: CGFloat {
        return UITableViewAutomaticDimension
    }
    
    var imageItem: MediaItem? {
        switch self {
        case .Media(let image):
            return image
        default:
            return nil
        }
    }
    
    var url: NSURL? {
        switch self {
        case .URLMention(let urlKeyword):
            return NSURL(string: urlKeyword)
        default:
            return nil
        }
    }
    
    var detail: (keyword: String?, identifier: String) {
        switch self {
        case .Media(_):
            return (nil, TableViewControllerConstants.MediaReuseIdentifier)
        case .URLMention(let url):
            return (url, TableViewControllerConstants.MentionReuseIdentifier)
        case .UserMention(let user):
            return (user, TableViewControllerConstants.MentionReuseIdentifier)
        case .HashTag(let hashTag):
            return (hashTag, TableViewControllerConstants.MentionReuseIdentifier)
        }
    }
}
