//
//  StoriesCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 05.07.2021.
//

import UIKit

class StoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var storiesImg: UIImageView!

    func configureCell(storyImg: String) {
        storiesImg.image = downloadImg(imgString: storyImg)
    }
}
