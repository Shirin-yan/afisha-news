//
//  BannerScrollView.swift
//  Turkmen Afisha News
//
//  Created by izi on 05.07.2021.
//

import Foundation

class BannerScrollView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    let bannerImages = ["circle_ico copy.png", "circle_ico copy.png", "circle_ico copy.png"]

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
            let img = bannerImages[indexPath.item]
            cell.configureCell(bannerImage: img)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: view.bounds.width, height: CGFloat(250))
    }
    

}


}
