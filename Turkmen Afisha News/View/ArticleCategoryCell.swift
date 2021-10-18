//
//  newsCategoryCellTableViewCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 08.07.2021.
//

import UIKit

class ArticleCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var viewForColoring: RoundedShadowView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    func configureCell(articleCategory: ArticleCategory) {
        let json = (articleCategory.images!).data(using: .utf8)!
        guard let imgString = (try? JSONDecoder().decode(Image.self, from: json).webImage) else { return }

        img.image = downloadImg(imgString: imgString)
        let tit = strInSelectedLang(lang: appLang, stingsToSelect: [articleCategory.enName, articleCategory.ruName, articleCategory.tmName])
        title.text = tit
        quantity.text = String(articleCategory.articleCount!)
    }
    
    func configureCellTitleOnly(articleCategory: ArticleCategory, toColor: Bool) {
        let tit = strInSelectedLang(lang: appLang, stingsToSelect: [articleCategory.enName, articleCategory.ruName, articleCategory.tmName])
        title.text = tit
        if toColor {
            viewForColoring.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.6470588235, blue: 1, alpha: 1)
            title.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        } else {
            viewForColoring.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
