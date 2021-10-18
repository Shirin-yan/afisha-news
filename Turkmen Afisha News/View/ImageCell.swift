//
//  ImageCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 17.09.2021.
//

import UIKit

//this class is used to show images in add stories vc
class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var deleteImageBtn: UIButton!
    
    var actionBlock: (() -> (Int))!
    
    func configureCell (img: UIImage){
        selectedImage.image = img
    }
    
    func configureCellWithBorder (img: UIImage, border: Bool ){
        selectedImage.image = img
        selectedImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        if border {
            selectedImage.layer.borderWidth = 2
        } else {
            selectedImage.layer.borderWidth = 0
        }
    }
}
