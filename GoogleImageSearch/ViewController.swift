//
//  ViewController.swift
//  GoogleImageSearch
//
//  Created by Catherine Korovkina on 08.06.14.
//  Copyright (c) 2014 Misestranger. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,
                    UICollectionViewDataSource, UICollectionViewDelegate {
    var foundObjects : NSMutableArray!;
    var headerView : HeaderViewClass!;
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder);
    }
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);

    }
    
    @IBAction func onButtonPressed(sender : UIButton) {
        var searchString = self.headerView.searchTextField.text;
        var baseString = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=";
        var finalString = baseString.stringByAppendingString(searchString);
        var encodedString  = finalString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
        var url  = NSURL.URLWithString(encodedString);
        var request : NSURLRequest = NSURLRequest(URL: url);
        println(finalString);
        println(url);
        println(request);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{response,data,error in
            dispatch_async(dispatch_get_main_queue(),
                {
                    if error {
                        println(response);
                        println(error);
                    }
                    else {
                        //                    var parseError : NSErrorPointer;
                        var responseJson : NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
                            options : NSJSONReadingOptions.MutableContainers,
                            error: nil) as NSDictionary;
                        var results: NSDictionary = responseJson["responseData"] as NSDictionary
                        self.foundObjects = NSMutableArray(array: results["results"] as NSArray);
                        println("response = \(self.foundObjects)");
                        self.collectionView.reloadData();
                    }
                });
            });
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.foundObjects = NSMutableArray(capacity: 10);
        self.headerView = nil;
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Search";
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
            var headerView:UICollectionReusableView! = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderViewId", forIndexPath: indexPath) as UICollectionReusableView;
            reusableview = headerView;
            self.headerView = headerView as HeaderViewClass;
        }
        
        return reusableview;
    }
}

