//
//  RegistrationViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 14.08.2021.
//

import UIKit
import Alamofire
import FirebaseAuth

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    var isHidden = true
    var parameters: String!
    var data: [String: String]!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var shareCodeTextField: UITextField!
    @IBOutlet var showPasswordOutletCollection: [UIButton]!
    @IBOutlet weak var showPasswordBtn1: UIButton!
    @IBOutlet weak var showPasswordBtn2: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        shareCodeTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        shareCodeTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func showPassword1Clicked(_ sender: Any) {
        isHidden = !isHidden
        showHidePassword(show: isHidden)
    }
    
    
    @IBAction func showPassword2Clicked(_ sender: Any) {
        isHidden = !isHidden
        showHidePassword(show: isHidden)
    }
    
    @IBAction func signInClicked(_ sender: Any) {  
        data =  ["username": usernameTextField.text!,
                 "phoneNumber": "+993" + phoneNumberTextField.text!,
                 "password": passwordTextField.text!,
                 "shareCode": shareCodeTextField.text ?? ""]
        
        if data["username"] == "" || data["phoneNumber"] == "+993" || data["password"] == "" {
            self.showAlert(code: 10)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            showAlert(code: 13)
            return
        }

        GettingApi().doesNotExist(data: data) { (response) in
            if response.phoneNumber && response.username {
                self.sendOTP(toPhoneNumber: self.data["phoneNumber"]!)
            } else {
                self.showAlert(code: 14)
            }
        }
    }
       
    func showHidePassword (show: Bool) {
        let img: UIImage!
        if show { img = UIImage (named: "views")
        } else { img = UIImage (named: "hide") }
        showPasswordOutletCollection.forEach { (btn) in
            btn.setImage(img, for: .normal)
        }
        passwordTextField.isSecureTextEntry = show
        confirmPasswordTextField.isSecureTextEntry = show
    }
    

    func sendOTP (toPhoneNumber: String!) {
        PhoneAuthProvider.provider().verifyPhoneNumber(toPhoneNumber, uiDelegate: nil) { (id, error) in
            if error == nil {
                UserDefaults.standard.set(id, forKey: "verId")
                self.performSegue(withIdentifier: "smsConfirmation", sender: self)
            } else {
                self.showAlert(code: 5)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SmsConfirmationViewController {
            vc.data = data
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



