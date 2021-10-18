//
//  ContactUsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 24.07.2021.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    

    @IBOutlet var contactLbls: [UILabel]!
    @IBOutlet weak var caontact: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caontact.text = strInSelectedLang(lang: appLang, stingsToSelect: ["Contact information", "Контактная информация", "Kontakt maglumatlar"])
        if contactsFiltered.isEmpty {
            contactLbls[0].isHidden = false
            contactLbls[0].text = strInSelectedLang(lang: appLang, stingsToSelect: ["Contact Informtion was found", "Контактной информации не имеется", "Kontakt maglumat tapylmady"])
        } else {
        settingUpUi(contacts: contactsFiltered)
        }
    }
    
    func settingUpUi (contacts: [String]){
        for ind in 0..<contacts.count {
            contactLbls[ind].isHidden = false
            contactLbls[ind].text = contacts[ind]
        }
    }
    
    @IBAction func bgClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
