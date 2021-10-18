//
//  AddStoriesViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 17.09.2021.
//

import UIKit
import BSImagePicker
import Photos
import Alamofire

class AddStoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewWithPicker: UIView!
    
    var pickerData: [String] = []
    var selectedImages : [UIImage] = []
    var makeBorderTo: Int = 0
    var day: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if status == 2 || status == 3 {
            picker.delegate = self
            picker.dataSource = self
            
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
            selectImages()
        }
        
        for i in 1...41 {
            pickerData.append("\(i)")
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if status == 1 {
            let title = self.strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = self.strInSelectedLang(lang: appLang, stingsToSelect: ["To post Stories you should become official first.", "Что-бы выложить сторис нужно сначала получить статус официального", "Stories goýmak üçin ilki bilen ofisial statusyny almaly"])
            self.simpleAlert(title: title, message: message) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func selectImages ()  {
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
                                    
                                    self.imageView.image = self.selectedImages[0]
                                }
                                
                            }
                           }
        )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell {
            let data: UIImage = selectedImages[indexPath.item]
            let toBorder = indexPath.item == makeBorderTo
            cell.configureCellWithBorder(img: data, border: toBorder)
            cell.deleteImageBtn.tag = indexPath.item
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.image = selectedImages[indexPath.item]
        makeBorderTo = indexPath.item
        imagesCollectionView.reloadData()
    }
    
    
    @IBAction func deleteImageClicked(_ sender: UIButton) {
        selectedImages.remove(at: sender.tag)
        imagesCollectionView.reloadData()
        if selectedImages.isEmpty == true {
            dismiss(animated: true, completion: nil)
        } else {
            imageView.image = selectedImages[0]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            day = Int (pickerData [row])
        }
    }
    
    
    
    @IBAction func postClicked(_ sender: Any) {
        viewWithPicker.isHidden = false
    }
    
    
    @IBAction func sendClicked(_ sender: Any) {
        let today = Date()
        var dateComponent = DateComponents()
        dateComponent.day = day
        
        let futureDate = "\(Calendar.current.date(byAdding: dateComponent, to: today)!)"
        
        let endTime: String? = futureDate.changeFormatOfDate(inputFormat: "yyyy-MM-dd HH:mm:ssZ", outputFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        
        let parameters = ["endTime": endTime]
        
        
        let url: URLConvertible = "http://tmafisha.com:3010/api/v1/stories"
        let images = selectedImages
        let header : HTTPHeaders = HTTPHeaders(["Authorization" : "Bearer " + token])
        
        
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
            print (response)
            if let err = response.error{
                print(err)
                self.showAlert(code: 5)
                return
            } else {
                self.showAlert(code: 6)
            }
        }
    }
}
