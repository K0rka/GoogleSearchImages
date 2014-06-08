//
//  HeaderViewClass.swift
//  GoogleImageSearch
//
//  Created by Catherine Korovkina on 08.06.14.
//  Copyright (c) 2014 Misestranger. All rights reserved.
//

import UIKit


//
class HeaderViewClass: UICollectionReusableView {
    @IBOutlet var searchTextField : UITextField
//
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }
    override func awakeFromNib()  {
        super.awakeFromNib();
    }
    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder);
    }
//
//    /*
//    // Only override drawRect: if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect)
//    {
//    // Drawing code
//    }
//    */
//
}