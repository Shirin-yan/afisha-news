//
//  CategoryCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 06.07.2021.
//

import UIKit

class UserCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    func configureCell(category: UserCategory) {
        let json = (category.images!).data(using: .utf8)!
        guard let imgString = (try? JSONDecoder().decode(Image.self, from: json).blueImage) else { return }
        img.image = downloadImg(imgString: imgString)
        let name = strInSelectedLang(lang: appLang, stingsToSelect: [category.enName, category.ruName, category.enName])
        nameLbl.text = name
    }
}







class UserCategoryCellTitle: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewForColoring: UIView!
    
    func configureCell (category: UserCategory, toColor: Bool) {
        let name = strInSelectedLang(lang: appLang, stingsToSelect: [category.enName, category.ruName, category.enName])
        titleLbl.text = name
        if toColor {
            viewForColoring.backgroundColor = #colorLiteral(red: 0.1618077478, green: 0.6484029198, blue: 1, alpha: 1)
            titleLbl.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        } else {
            viewForColoring.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            titleLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
    }
}
