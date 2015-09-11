//
//  CardView.swift
//  BitDate
//
//  Created by User  on 2015-08-21.
//  Copyright (c) 2015 Wub.com. All rights reserved.
//

import Foundation
import UIKit
class CardView: UIView {
    private let imageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    
    var name: String? {
        didSet {
            if let name = name {
                nameLabel.text = name
            }
        }
    }
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            }
        }
    }

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    init() {
        super.init(frame: CGRectZero)
        initialize()
    }
    private func initialize() {
        // added from bitfountain
        self.nameLabel.backgroundColor = UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1.0)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.backgroundColor = UIColor.redColor()
        addSubview(imageView)
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(nameLabel)
        backgroundColor = UIColor.whiteColor()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
        setConstraints()

    }
    
    private func setConstraints() {
        // Constraints for ImageView
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0))
        
        //Constraints for Label
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -40))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -10))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: -10))
    }
}
