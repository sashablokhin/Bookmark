//
//  BookmarkService.swift
//  Bookmark
//
//  Created by Alexander Blokhin on 07.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import Foundation


public class BookmarkService {
    
    public lazy var bookmarks: [Bookmark] = BookmarkService.sharedService.loadBookmarks()
    
    public class var sharedService: BookmarkService {
        struct Singleton {
            static let instance = BookmarkService()
        }
        return Singleton.instance
    }
    
    init() {
        let queue = NSOperationQueue.mainQueue()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserverForName(UIApplicationWillResignActiveNotification, object: nil, queue: queue) { _ in
            self.saveBookmarks()
        }
        
        notificationCenter.addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: queue) { _ in
            self.bookmarks = self.loadBookmarks()
        }
    }
    
    public func loadBookmarks() -> [Bookmark] {
        var loadedBookmarks: [Bookmark] = []
        if (NSFileManager.defaultManager().fileExistsAtPath(getFileUrl().path ?? "")) {
            var loadError: NSError?
            let bookmarksData: NSData?
            do {
                bookmarksData = try NSData(contentsOfFile: getFileUrl().path!, options: .DataReadingUncached)
            } catch let error as NSError {
                loadError = error
                bookmarksData = nil
            }
            if loadError != nil {
                NSLog("Loading Error: %@", loadError!)
            } else {
                let unarchivedBookmarks: [Bookmark]! = NSKeyedUnarchiver.unarchiveObjectWithData(bookmarksData!) as! Array
                if unarchivedBookmarks != nil {
                    loadedBookmarks = unarchivedBookmarks
                }
            }
        }
        
        return loadedBookmarks
    }
    
    func getFileUrl() -> NSURL {
        if let containerUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.jampps.Bookmark") {
            return containerUrl.URLByAppendingPathComponent("BookmarkService.dat")
        } else {
            fatalError("Error obtaining shared container URL. Check your App Group configuration.")
        }
    }
    
    public func saveBookmarks() {
        let bookmarksData = NSKeyedArchiver.archivedDataWithRootObject(bookmarks)
        var saveError: NSError?
        do {
            try bookmarksData.writeToURL(getFileUrl(), options: NSDataWritingOptions.AtomicWrite)
        } catch let error as NSError {
            saveError = error
        }
        if saveError != nil {
            NSLog("Saving Error: %@", saveError!)
        }
    }
    
    public func addBookmark(bookmark: Bookmark) {
        bookmarks.insert(bookmark, atIndex: 0)
    }
    
}