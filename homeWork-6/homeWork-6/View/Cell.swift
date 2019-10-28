//
//  Cell.swift
//  homeWork-6
//
//  Created by Максим Жуков on 28/10/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        selectionStyle = .none
        textLabel!.lineBreakMode = .byWordWrapping
        
        
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView?.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        imageView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView?.im = self.resizeImage(image: UIImage(named: "yourImageName")!, targetSize: CGSize(width: 200.0, height: 200.0))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}

