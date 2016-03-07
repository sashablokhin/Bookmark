//
//  Bookmark.swift
//  Bookmark
//
//  Created by Alexander Blokhin on 07.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import Foundation

public class Bookmark: NSObject, NSCoding {
    
    public let url: NSURL?
    public let title: String
    
    public init(url: NSURL, title: String) {
        self.url = url
        self.title = title
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("title") as! String
        url = aDecoder.decodeObjectForKey("url") as? NSURL
    }
    
    public func encodeWithCoder(aCoder: NSCoder)  {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(url, forKey: "url")
    }
    
}