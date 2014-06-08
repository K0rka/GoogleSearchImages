//
//  ViewController.swift
//  GoogleImageSearch
//
//  Created by Catherine Korovkina on 08.06.14.
//  Copyright (c) 2014 Misestranger. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var foundObjects : NSMutableArray!;
    var headerView : HeaderViewClass!;
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder);
    }
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.headerView = nil;
        self.foundObjects = NSMutableArray(capacity: 10);
    }
    
    @IBAction func onButtonPressed(sender : UIButton) {
        var searchString = self.headerView.searchTextField.text;
        var baseString = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="
        var finalString = baseString.stringByAppendingString(searchString);
        var url  = NSURL.URLWithString(finalString);
        var request : NSURLRequest = NSURLRequest(URL: url);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{response,data,error in
            dispatch_async(dispatch_get_main_queue(),
                {
                    var error : NSErrorPointer;
                    var responseJson : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary;
                    var results: NSDictionary = responseJson["responseData"] as NSDictionary
//                    results = results["responseData"] as NSDictionary;
                    self.foundObjects = NSMutableArray(array: results["results"] as NSArray);
                    println("response = \(self.foundObjects)");
                    NSLog("resp ");
                    self.collectionView.reloadData()
                });
            });
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.foundObjects = NSMutableArray(capacity: 10)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var newCell : CellWithImageView! = collectionView.dequeueReusableCellWithReuseIdentifier("FoundImageCell", forIndexPath: indexPath!) as CellWithImageView;
        
        if (self.foundObjects.count > indexPath.row) {
            var dict : NSDictionary = self.foundObjects[indexPath.row] as NSDictionary;
            var url = NSURL.URLWithString(dict["url"] as NSString);
            var request = NSURLRequest(URL : url);
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{response,data,error in
                dispatch_async(dispatch_get_main_queue(),
                    {
                        newCell.imageView.image = UIImage(data: data as NSData);
                    });
                
                });
        }
        else {
            newCell.backgroundColor = UIColor.blueColor();
        }
        return newCell ;
    }
    override func collectionView(collectionView: UICollectionView!, viewForSupplementaryElementOfKind kind: String!, atIndexPath indexPath: NSIndexPath!) -> UICollectionReusableView! {
        var reusableview:UICollectionReusableView! = nil ;
        
        if ( kind == UICollectionElementKindSectionHeader ) {
            var headerView:UICollectionReusableView! = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderViewIdtf", forIndexPath: indexPath) as UICollectionReusableView;
            reusableview = headerView;
            self.headerView = headerView as HeaderViewClass;
        }
        
        return reusableview;
    }
}

