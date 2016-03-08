//
//  ShowUrlViewController.swift
//  Bookmark
//
//  Created by Alexander Blokhin on 07.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ShowUrlViewController: UIViewController {

    var url: NSURL!
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
