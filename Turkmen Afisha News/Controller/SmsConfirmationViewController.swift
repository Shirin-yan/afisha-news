//
//  SmsConfirmationViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 15.08.2021.
//

import UIKit
import Alamofire
import FirebaseAuth

class SmsConfirmationViewController: UIViewController, UITextFieldDelegate {
    var data: [String: String]!
    var verificationId: String!
    var recovery: Bool! = false
    
    @IBOutlet weak var otpCodeTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpCodeTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        otpCodeTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func registerClicked(_ sender: UIButton!) {
        spinner.startAnimating()
        guard let otpCode = otpCodeTextField.text else { return }
        guard let verificationId = UserDefaults.standard.string(forKey: "verId") else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpCode)
        
        Auth.auth().signIn(with: credential) { (authData, error) in
            if error == nil {
                self.registerUser()
                self.spinner.stopAnimating()
            } else {
                self.spinner.stopAnimating()
                self.showAlert(code: 5)
            }
        }
    }
    
    func registerUser () {
        GettingApi().loginRegister(data: data, toLogin: false, toRecover: recovery) { (res) in
            if res.success {
                token = res.token!
                status = res.user?.status
                id = res.user?.id
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainVc")
                self.navigationController?.pushViewController(vc!, animated: true)
                self.showAlert(code: 12)
            }
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
