//
//  LoginViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 12.08.2021.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var vc: UIViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.delegate = self
        passwordTextField.delegate = self
        navigationController?.navigationBar.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let data = ["username": nameTextField.text!,
                    "password": passwordTextField.text!]
        
        if data["username"] == "" || data["password"] == "" {
            self.showAlert(code: 10)
            return
        }
        
        spinner.isHidden = false
        
        GettingApi().loginRegister(data: data, toLogin: true) { (res) in
            if res.success {
                token = res.token!
                status = res.user?.status
                id = res.user?.id
                self.showAlert(code: 8)
            } else {
                self.showAlert(code: 9)
            }
        }
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
