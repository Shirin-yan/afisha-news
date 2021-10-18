//
//  AllOfficialsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 12.07.2021.
//

import UIKit

class AllOfficialsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let width = UIScreen.main.bounds.width
    var toColor: Bool!
    var widthPerItem : CGFloat = 0
    var userCat = userCategories!
    var isClicked = false

    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var allCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var officialsCollectionView: UICollectionView!
    @IBOutlet weak var itemIntoRowBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        
        allCategoriesCollectionView.delegate = self
        allCategoriesCollectionView.dataSource = self
        //allCategoriesCollectionView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        
        officialsCollectionView.delegate = self
        officialsCollectionView.dataSource = self
        //cardsCollectionView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        
        case bannersCollectionView:
            return officialsBanners.count
            
        case allCategoriesCollectionView:
            return userCategories.count
        case officialsCollectionView:
            if officialsOfUserCategory == nil {
                return 0
            }
                return officialsOfUserCategory.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        
        case bannersCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                cell.configureCell(banner: officialsBanners[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
        
        case allCategoriesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCategoryCellTitle", for: indexPath) as? UserCategoryCellTitle {
                toColor = officialCellToColor == indexPath.item
                cell.configureCell(category: userCategories [indexPath.item], toColor: toColor)
                return cell
            }
            return UICollectionViewCell()
       
        case officialsCollectionView:
            if isClicked {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officialCellLong", for: indexPath) as? OfficialCellLong {
                    cell.configureCell(official: officialsOfUserCategory[indexPath.item])
                    cell.actionBlock = {
                        return officialsOfUserCategory[indexPath.item].id
                    }
                    return cell
                }
            } else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officialCell", for: indexPath) as? OfficialCell {
                    cell.configureCell(official: officialsOfUserCategory[indexPath.item])
                    cell.actionBlock = {
                        return officialsOfUserCategory[indexPath.item].id
                    }
                    return cell
                }
            }
        return UICollectionViewCell()
        
        default:
            return UICollectionViewCell()
        }
    }
    

    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        
        case bannersCollectionView:
            return CGSize (width: width, height: CGFloat(250))
        
        case allCategoriesCollectionView:
            let width = view.bounds.width/3
            return CGSize (width: width, height:  CGFloat(80))
            
        case officialsCollectionView:
            if isClicked {
                return CGSize(width: width, height:90)
            } else {
                return CGSize(width: 120, height:180)
            }
        default:
            return CGSize (width: 0, height: 0)
        }
    }

    @IBAction func itemIntoRowClicked(_ sender: Any) {
        isClicked = !isClicked
        if isClicked {
            itemIntoRowBtn.setImage(UIImage(named: "display-item"), for: .normal)
        } else {
            itemIntoRowBtn.setImage(UIImage(named: "display-row"), for: .normal)
        }
        officialsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        
        case allCategoriesCollectionView:
            officialCellToColor = indexPath.item
            allCategoriesCollectionView.reloadData()
            
            officialsOfUserCategory.removeAll()
            officialsofUserCategory (selectedCategoryInd: indexPath.item)
            officialsCollectionView.reloadData()
        
        case officialsCollectionView:
            let id = officials [indexPath.item].id
            GettingApi().getOfficial(id: id) { (official) in
                selectedOfficial = official.user
                self.performSegue(withIdentifier: "toOfficial", sender: self)
            }
            
   
        
        default:
            return
        }
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
        favoriteClicked()
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        searchClicked()
    }
    
    @IBAction func settingsClicked(_ sender: UIButton) {
        settingsClicked()
    }
    
    @IBAction func profileClicked(_ sender: Any) {
        profileClicked()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        addClicked()
    }
    
}
