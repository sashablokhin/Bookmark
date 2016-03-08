//
//  ActionViewController.swift
//  Bookmarker
//
//  Created by Alexander Blokhin on 08.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import MobileCoreServices
import BookmarkKit

class ActionViewController: UIViewController {

    @IBOutlet var bookmarkTitleTextField: UITextField!
    
    var bookmarkURL: NSURL!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        let itemProvider = extensionItem.attachments?.first as! NSItemProvider
        
        let propertyList = String(kUTTypePropertyList)
        if itemProvider.hasItemConformingToTypeIdentifier(propertyList) {
            itemProvider.loadItemForTypeIdentifier(propertyList, options: nil, completionHandler: { (item, error) -> Void in
                let dictionary = item as! NSDictionary
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    let urlString = results["currentUrl"] as? String
                    self.bookmarkURL = NSURL(string: urlString!)
                }
            })
        } else {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        var statusMessage: NSString
        
        if (bookmarkTitleTextField.text!.isEmpty) {
            statusMessage = "Cannot save bookmark without a title"
        } else {
            let bookmark = Bookmark(url: bookmarkURL, title: bookmarkTitleTextField.text!)
            let bookmarkService = BookmarkService.sharedService
            bookmarkService.addBookmark(bookmark)
            bookmarkService.saveBookmarks()
            statusMessage = "Saved successfully"
        }
        
        let extensionItem = NSExtensionItem()
        let statusDictionary = [NSExtensionJavaScriptFinalizeArgumentKey : ["statusMessage" : statusMessage]]
        extensionItem.attachments = [NSItemProvider(item: statusDictionary, typeIdentifier: kUTTypePropertyList as NSString as String)]
        
        self.extensionContext!.completeRequestReturningItems([extensionItem], completionHandler: nil)
    }

}
