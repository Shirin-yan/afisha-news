//
//  RecoverPasswordViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 09.10.2021.
//

import UIKit
import Alamofire
import FirebaseAuth

class RecoverPasswordViewController: UIViewController {
    var isHidden = true
    var data: [String: String]!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet var showPasswordOutletCollection: [UIButton]!
    @IBOutlet weak var showPasswordBtn1: UIButton!
    @IBOutlet weak var showPasswordBtn2: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        data =  ["phoneNumber": "+993" + phoneNumberTextField.text!,
                     "password": passwordTextField.text!]
        
        if data["phoneNumber"] == "+993" || data["password"] == "" {
            showAlert(code: 10)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            showAlert(code: 13)
            return
        }
       
        sendOTP(toPhoneNumber: data["phoneNumber"])
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
                self.performSegue(withIdentifier: "smsConfirmation1", sender: self)
            } else {
                self.showAlert(code: 5)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SmsConfirmationViewController {
            vc.data = data
            vc.recovery = true
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

