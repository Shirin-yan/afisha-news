//
//  AddViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 24.07.2021.
//

import UIKit

class AddViewController: UIViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func bgClicked(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func addNewsClicked(_ sender: Any) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "addNews") as! AddNewsViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
