//
//  LangSelectionViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 23.07.2021.
//

import UIKit

class LangSelectionViewController: UIViewController {
    
   
    @IBOutlet var viewForBtns: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch appLang {
        case "ru":
           changeLang(blueBtnInd: 0)
        case "en":
            changeLang(blueBtnInd: 1)
        case "tm":
            changeLang(blueBtnInd: 2)
        
        default:
            break
        }
    }
    
    
    func changeLang (blueBtnInd: Int) {
        viewForBtns.forEach { (view) in
            view.layer.cornerRadius = 22.5
            view.layer.borderWidth = 1.5
            view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        viewForBtns[blueBtnInd].layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }
    
    
    @IBAction func rusClicked(_ sender: Any) {
        changeLang(blueBtnInd: 0)
        UserDefaults.standard.setValue("ru", forKey: "Lang")
        appLang = "ru"
    }
    
    @IBAction func enClicked(_ sender: Any) {
        changeLang(blueBtnInd: 1)
        UserDefaults.standard.setValue("en", forKey: "Lang")
        appLang = "en"
    }
    
    @IBAction func tmClicked(_ sender: Any) {
        changeLang(blueBtnInd: 2)
        UserDefaults.standard.setValue("tm", forKey: "Lang")
        appLang = "tm"
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
