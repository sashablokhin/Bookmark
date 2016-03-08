//
//  TableViewController.swift
//  Bookmark
//
//  Created by Alexander Blokhin on 07.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import BookmarkKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BookmarkService.sharedService.bookmarks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let bookmark = BookmarkService.sharedService.bookmarks[indexPath.row]
        
        cell.textLabel?.text = bookmark.title

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("openURL", sender: self)
    }
    

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "openURL") {
            let indexPath: NSIndexPath = tableView.indexPathForSelectedRow!
            let bookmark = BookmarkService.sharedService.bookmarks[indexPath.row]
            
            let destViewController = segue.destinationViewController as! ShowUrlViewController
            destViewController.url = bookmark.url
            
        }
        
    }

}
