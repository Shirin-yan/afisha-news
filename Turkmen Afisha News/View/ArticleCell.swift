//
//  ArticleCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 08.07.2021.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    func configureCell(article: Article) {
        let date = stringToDate(stringDate: article.createdAt)
        let arrOfImg = parsingStringArray(str: article.images)
        img.image = downloadImg(imgString: arrOfImg[0])
        title.text = article.title
        content.text = strInSelectedLang(lang: appLang, stingsToSelect: [article.enContent ?? "", article.ruContent ?? "", article.tmContent ?? ""])
        dateLbl.text = "\(dateToPrint(date: date))"
    }
    
    
    
    func stringToDate (stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: stringDate) {
          return date
        }
        return Date()
    }
    
    
    func dateToPrint (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
