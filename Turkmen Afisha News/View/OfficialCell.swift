//
//  CardsCell.swift
//  Turkmen Afisha News
//
//  Created by izi on 06.07.2021.
//

import UIKit

class OfficialCell: UICollectionViewCell {
    var actionBlock: (() -> (Int))!
    @IBOutlet weak var officialImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var subscirbeBtn: UIButton!
    
    func configureCell(official: Official) {
        
        subscirbeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
        subscirbeBtn.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Follow", "Подписаться", "Yzarla"]), for: .normal)
        if followings?.contains(official.id) == true {
            subscirbeBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            subscirbeBtn.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Followed", "Подписан", "Yzarlaýan"]), for: .normal)
        }
        
        if official.image != nil {
            officialImg.image = downloadImg(imgString: official.image!)
        }
        
        nameLbl.text = official.username
        statusLbl.text = official.note
    }
    
        
        
    @IBAction func subscribeClicked(_ sender: Any) {
        
        let id = actionBlock!()
        if token != nil {
            if subscirbeBtn.backgroundColor == #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1) {
                GettingApi().followUnfollowRequest(officialId: id, toFollow: true) { (response) in
                    if response.success {
                        followings?.append(id)
                        self.subscirbeBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                        self.subscirbeBtn.setTitle(self.strInSelectedLang(lang: appLang, stingsToSelect: ["Followed", "Подписан", "Yzarlaýan"]), for: .normal)
                    }
                }
                
            } else {
                GettingApi().followUnfollowRequest(officialId: id, toFollow: false) { (response) in
                    if response.success {
                        followings = followings?.filter{ $0 != id}
                        self.subscirbeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                        self.subscirbeBtn.setTitle(self.strInSelectedLang(lang: appLang, stingsToSelect: ["Follow", "Подписаться", "Yzarla"]), for: .normal)
                    }
                }
            }
        }
    }
}




class OfficialCellLong: UICollectionViewCell {
    var actionBlock: (() -> (Int))!
    @IBOutlet weak var officialImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var seperatorLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seperatorLine.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func configureCell (official: Official) {
        if followings?.contains(official.id) == true {
            subscribeBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            subscribeBtn.setTitle("Subscribed", for: .normal)
        } else {
            subscribeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
        }
        
        if official.image != nil {
            officialImg.image = downloadImg(imgString: official.image!)
        }
        nameLbl.text = official.username
    }
    
    @IBAction func subscribeClicked(_ sender: Any) {
        let id = actionBlock!()
        if token != nil {
            if subscribeBtn.backgroundColor == #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1) {
                GettingApi().followUnfollowRequest(officialId: id, toFollow: true) { (response) in
                    if response.success {
                        followings?.append(id)
                        self.subscribeBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    }
                }
            } else {
                GettingApi().followUnfollowRequest(officialId: id, toFollow: false) { (response) in
                    if response.success {
                        followings = followings?.filter{ $0 != id}
                        self.subscribeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                    }
                }
            }
        }
    }
}



