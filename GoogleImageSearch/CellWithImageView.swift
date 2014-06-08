//
//  CellWithImageView.swift
//  GoogleImageSearch
//
//  Created by Catherine Korovkina on 08.06.14.
//  Copyright (c) 2014 Misestranger. All rights reserved.
//

import UIKit

class CellWithImageView: UICollectionViewCell {
    @IBOutlet var imageView : UIImageView
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
    override func prepareForReuse()  {
        self.imageView.image = nil;
    }
    
}
