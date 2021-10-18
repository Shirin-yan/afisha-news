//
//  SettingsContactUsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 22.09.2021.
//

import UIKit

class SettingsContactUsViewController: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var sendBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func hidingUnhiding (ind: Int) {
        textFields[ind].isHidden = !textFields[ind].isHidden
        sendBtns[ind].isHidden = !sendBtns[ind].isHidden
    }
    
    @IBAction func thanksClicked(_ sender: Any) {
        hidingUnhiding(ind: 0)
    }

    @IBAction func complaintsClicked(_ sender: Any) {
        hidingUnhiding(ind: 1)
    }
    
    @IBAction func offerslicked(_ sender: Any) {
        hidingUnhiding(ind: 2)
    }
    
    
    @IBAction func thanksSendBtnClicked(_ sender: Any) {
        showAlert(code: 11)
    }
    
    
    @IBAction func complaintsSendBtnClicked(_ sender: Any) {
        showAlert(code: 11)

    }
    
    @IBAction func offersSendBtnClicked(_ sender: Any) {
        showAlert(code: 11)
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
