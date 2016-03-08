//
//  ViewController.swift
//  Bookmark
//
//  Created by Alexander Blokhin on 07.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import BookmarkKit

class AddUrlViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        if (urlTextField.text!.isEmpty || titleTextField.text!.isEmpty) {
            let alert = UIAlertController(title: "Error", message: "Both field should be filled", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        } else {
            var urlString = urlTextField.text!
            
            if !urlString.containsString("http://") {
                urlString = "http://" + urlString
            }
            
            let bookmark = Bookmark(url: NSURL(string: urlString)!, title: titleTextField.text!)
            let bookmarkService = BookmarkService.sharedService
            bookmarkService.addBookmark(bookmark)
            bookmarkService.saveBookmarks()
            let alert = UIAlertController(title: "Saved", message: "Saved", preferredStyle: .Alert)

            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        titleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

