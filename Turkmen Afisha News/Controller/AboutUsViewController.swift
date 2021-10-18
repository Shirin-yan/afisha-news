//
//  AboutUsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 17.07.2021.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var aboutTextLbl: UILabel!
    @IBOutlet weak var aboutuslbl: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutuslbl.text = strInSelectedLang(lang: appLang, stingsToSelect: ["About me", "Про меня", "Men barada"])
        img.layer.cornerRadius = 50
        img.image = downloadImg (imgString: selectedOfficial.image!)
        nameLbl.text = selectedOfficial.username
        guard let about = selectedOfficial.about else { return }
        aboutTextLbl.attributedText = about.htmlToAttributedString
    }
    

    @IBAction func bgClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
