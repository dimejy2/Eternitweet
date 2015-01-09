//
//  ViewController.swift
//  Eternitweet
//
//  Created by Oladimeji Abidoye on 1/4/15.
//  Copyright (c) 2015 Dimeji Abidoye. All rights reserved.
//

//
//  ViewController.swift
//  snipSnap
//
//  Created by Oladimeji Abidoye on 1/4/15.
//  Copyright (c) 2015 Dimeji Abidoye. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    @IBOutlet weak var input: UITextView!
    
    var alertController :UIAlertController!
    var noTwitterController :UIAlertController!
    
    @IBAction func post(sender: AnyObject) {
        // input.pb_takeSnapshot()
        input.tintColor = UIColor.whiteColor()
        
        if input.text.utf16Count == 0 {
        
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if (input.text.utf16Count > 0) && (input.text.utf16Count < 140 ){
            var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText(input.text)
            self.presentViewController(tweetSheet, animated: false, completion: nil)
        }
         else if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText("Posted from eternitweet")
            tweetSheet.addImage(input.pb_takeSnapshot())
            
            self.presentViewController(tweetSheet, animated: false, completion: nil)
        }
        
        else {
            self.presentViewController(noTwitterController, animated: true, completion: nil)
        }
        
        input.tintColor = UIColor.blueColor()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        alertController = UIAlertController(title: "Invalid Post", message: "Please re-enter some text", preferredStyle: .Alert)
        
        noTwitterController = UIAlertController(title: "No Twitter Account Found", message: "Please go to settings and add a twitter account", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        noTwitterController.addAction(cancelAction)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.mainScreen().scale);
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return image;
    }
    
}