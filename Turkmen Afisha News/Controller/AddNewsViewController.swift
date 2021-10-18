//
//  AddNewsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 24.07.2021.
//

import UIKit
import BSImagePicker
import Photos
import Alamofire


class AddNewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var selectedImages : [UIImage] = []
    var titleOfNews: String!
    var content: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell {
            let data: UIImage = selectedImages[indexPath.item]
            cell.configureCell (img: data)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    @IBAction func addPhotosClicked(_ sender: Any) {
        presentImagePicker(ImagePickerController(),
                           select: { (asset) in },
                           deselect: { (asset) in },
                           cancel: { (assets) in },
                           finish: { (assets) in
                            self.selectedImages = []
                            let options: PHImageRequestOptions = PHImageRequestOptions()
                            options.deliveryMode = .highQualityFormat
                            
                            for asset in assets {
                                PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, info) in
                                    self.selectedImages.append (image!)
                                    self.imagesCollectionView.reloadData()
                                    print(self.selectedImages)
                                }
                            }
                           }
                           
        )
        
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        if titleTextField.text != "" || contentTextField.text != "" {
            titleOfNews = titleTextField.text!
            content = contentTextField.text!
        } else {
            
            self.simpleAlert(title: strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"]), message: strInSelectedLang(lang: appLang, stingsToSelect: ["You should fill all fields.", "Нужно заполнить все поля.", "Ähli meýdanlary doldurmaly."])) { }
        }
        
        
        uploadToServer()
    }
    
    func uploadToServer () {
        
        let parameters = ["title": titleOfNews,
                          "tmContent": content ]
        
        let url: URLConvertible = "http://tmafisha.com:3010/api/v1/articles"
        let images = selectedImages
        let header : HTTPHeaders = HTTPHeaders(["Authorization" : "Bearer " + token])
        
        print (header)
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if let temp = value {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            
            
            for (index, image) in images.enumerated() {
                multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "image\(index)", fileName: "image\(index).jpeg", mimeType: "image/jpeg")
            }
            
        }, to: url, method: .post, headers: header).responseJSON { (response) in
            
            if let err = response.error{
                print(err)
                self.showAlert(code: 5)
                return
            } else {
                self.showAlert(code: 7)
                
            }
        }
    }
    
}


