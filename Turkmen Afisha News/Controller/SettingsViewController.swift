//
//  SettingsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 23.07.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var sound: UIButton!
    @IBOutlet weak var region: UIButton!
    @IBOutlet weak var lang: UIButton!
    @IBOutlet weak var contact: UIButton!
    @IBOutlet weak var about: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var logout: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        loginBtn.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Log in", "Войти", "Akkaundyňa gir"]), for: .normal)
        sound.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Sound of notifications", "Звук уведомлений", "Habarlaryň sesi"]), for: .normal)
        region.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Select Region", "Выбрать регион", "Region saýla"]), for: .normal)
        lang.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Select Language", "Выбрать язык", "Dili saýla"]), for: .normal)
        contact.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Contact Us", "Связаться с нами", "Biz bilen habarlaş"]), for: .normal)
        about.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["About Us", "Про нас", "Biz barada"]), for: .normal)
        share.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Share", "Поделиться", "Paýlaşmak"]), for: .normal)
        logout.setTitle(strInSelectedLang(lang: appLang, stingsToSelect: ["Log out", "Выйти", "Akkaundyňdan çykyk"]), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if token == nil {
            let vc = storyboard?.instantiateViewController(identifier: "loginVc") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert(code: 3)
        }
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        if token == nil {
            showAlert(code: 0)
        } else {
            token = nil
            showAlert(code: 4)
        }
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        
    }
}

