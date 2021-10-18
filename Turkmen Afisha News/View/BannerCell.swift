//
//  BannerCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 05.07.2021.
//

import UIKit


//this class also used for showing images of article 
class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var articleImg: UIImageView!

    
    func configureCell(banner: Banner) {
        bannerImg.image = downloadImg(imgString: banner.image)
    }
    
    func configureCellOfArticle (img: String){
        articleImg.image = downloadImg(imgString: img)
    }
}
