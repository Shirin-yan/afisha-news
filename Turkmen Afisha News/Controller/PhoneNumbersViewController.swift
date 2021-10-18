//
//  PhoneNumbersViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 25.07.2021.
//

import UIKit

class PhoneNumbersViewController: UIViewController {

    @IBOutlet var phoneNumberLbls: [UILabel]!
    @IBOutlet weak var phone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.text = strInSelectedLang(lang: appLang, stingsToSelect: ["Phone numbers", "Номера телефонов", "Telefon belgileri"])
        if phoneNumbers.isEmpty {
            phoneNumberLbls[0].isHidden = false
            phoneNumberLbls[0].text = strInSelectedLang(lang: appLang, stingsToSelect: ["Phone numbers were not found", "Контактной информации не имеется", "Telefon belgisi tapylmady"])
        } else {
        settingUpUi(phoneNumbers: phoneNumbers)
        }
    }
    
    func settingUpUi (phoneNumbers: [String]){
        for ind in 0..<phoneNumbers.count {
            phoneNumberLbls[ind].isHidden = false
            phoneNumberLbls[ind].text = phoneNumbers[ind]
        }
    }

    @IBAction func bgClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
