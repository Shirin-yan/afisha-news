//
//  MainPage.swift
//  Turkmen Afisha News
//
//  Created by izi on 05.07.2021.
//

import UIKit
import Alamofire


class MainPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sview: UIScrollView!
    @IBOutlet weak var newslabl: UILabel!
    @IBOutlet weak var lastOfficials: UILabel!
    @IBOutlet weak var offiOfUserCategory: UILabel!
    @IBOutlet weak var allOff: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var userStoriesCollectionView: UICollectionView!
    @IBOutlet weak var officialsCollectionView: UICollectionView!
    @IBOutlet weak var userCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var newsCount: RoundBlueBorder!
    
    let width = UIScreen.main.bounds.width
    var btnPressed : Bool = false
    var countOfCategoriesShowed = 4
    var height = CGFloat (160.0)
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if toReload {
            spinner.startAnimating()
            viewDidLoad()
            toReload = false
        }

        newslabl.text = strInSelectedLang(lang: appLang, stingsToSelect: ["News", "Новости", "Täzelikler"])
        lastOfficials.text = strInSelectedLang(lang: appLang, stingsToSelect: ["Last Officials", "Поседние официальные", "Soňky ofisiallar"])
        offiOfUserCategory.text = strInSelectedLang(lang: appLang, stingsToSelect: ["Official Categories", "Официальные Категории", "Ofisiallaryň kategoriýalary"])
        allOff.text = strInSelectedLang(lang: appLang, stingsToSelect: ["All Official", "Все Официальные", "Ähli Ofisiallar"])    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Lang") != nil {
            appLang = UserDefaults.standard.value(forKey: "Lang") as! String
        }
        
        
        
        heightConstraint.constant = height
        
        GettingApi().getMainApi { (res) in
            self.makingResponseGlobal(data: res)
            self.newsCount.text = " +\(res.count.articles) "
            self.bannerCollectionView.delegate = self
            self.bannerCollectionView.dataSource = self
            self.officialsCollectionView.delegate = self
            self.officialsCollectionView.dataSource = self
            self.userCategoriesCollectionView.delegate = self
            self.userCategoriesCollectionView.dataSource = self
            self.bannerCollectionView.reloadData()
            self.userStoriesCollectionView.reloadData()
            self.officialsCollectionView.reloadData()
            self.userCategoriesCollectionView.reloadData()
            self.spinner.stopAnimating()
        }
        
        GettingApi().getBanner(id: 13) { (res) in
            officialsBanners = res.banners
        }
        
        GettingApi().getBanner(id: 1) { (res) in
            articleBanners = res.banners
        }
        
        GettingApi().getBanner(id: 18) { (res) in
            articleCatBanners = res.banners
        }
        
        GettingApi().getStories () { (res) in
            stories = res.stories
            userStories.append(stories[0])
            var idss = [stories[0].user.id]
            stories.forEach { (story) in
                if !(idss.contains(story.user.id)) {
                    userStories.append(story)
                    idss.append(story.user.id)
                }
            }
            self.userStoriesCollectionView.delegate = self
            self.userStoriesCollectionView.dataSource = self
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            return banners.count
        case userStoriesCollectionView:
            return userStories.count
        case officialsCollectionView:
            return officials.count
        case userCategoriesCollectionView:
            if userCategories.count >= countOfCategoriesShowed { return countOfCategoriesShowed }
            else { return userCategories.count }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        
        case bannerCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                cell.configureCell(banner: banners[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
            
        case userStoriesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storiesCell", for: indexPath) as? StoriesCell {
                cell.configureCell(storyImg: userStories[indexPath.item].user.image ?? "")
                return cell
            }
            return UICollectionViewCell()
            
            
        case officialsCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officialCell", for: indexPath) as? OfficialCell {
                cell.configureCell(official: officials[indexPath.item])
                cell.actionBlock = {
                    return officialsOfUserCategory[indexPath.item].id
                }
                return cell
            }
            return UICollectionViewCell()
            
            
        case userCategoriesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCategoryCell", for: indexPath) as? UserCategoryCell {
                cell.configureCell(category: userCategories[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
            
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case bannerCollectionView:
            return CGSize (width: width, height: CGFloat(250))
            
        case userStoriesCollectionView:
            return CGSize (width: 85, height: 85)
            
        case officialsCollectionView:
            return CGSize (width: 120, height:  CGFloat(180))
            
        case userCategoriesCollectionView:
            return CGSize(width: (width - 10) / 4 - 5 , height:130)
            
        default:
            return CGSize (width: 0, height: 0)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        
        case userStoriesCollectionView:
            selectedStories = indexPath.item
            performSegue(withIdentifier: "toStories", sender: self)
            
        
        case officialsCollectionView:
            spinner.startAnimating()
            let id = officials [indexPath.item].id
            GettingApi().getOfficial(id: id) { (official) in
                selectedOfficial = official.user
                self.spinner.stopAnimating()
                self.performSegue(withIdentifier: "toOfficial", sender: self)
            }
            
            
        case userCategoriesCollectionView:
            officialCellToColor = indexPath.item
            officialsofUserCategory (selectedCategoryInd: indexPath.item)
            performSegue(withIdentifier: "userCatsSelected", sender: self)
            
        default:
            break
        }
    }
    
    @IBAction func allCategoriesClicked(_ sender: Any) {
        officialsOfUserCategory = officials
        officialCellToColor = 0
        performSegue(withIdentifier: "userCatsSelected", sender: self)
    }
    
 
    
    
    // Footer of userCategories Collection View (Show more or less btn )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView == userCategoriesCollectionView {
            return CGSize (width: width, height: 30)
        }
        return CGSize (width: 0, height: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == userCategoriesCollectionView {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! Footer
            return footer
        }
        return UICollectionReusableView()
    }
    
    
    

    
    @IBAction func showMoreClicked(_ sender: Any) {
        btnPressed = !btnPressed
        if btnPressed {
            countOfCategoriesShowed = userCategories.count
            let rowCount: Double = ceil( Double (countOfCategoriesShowed) / 4.0)
            height = CGFloat (rowCount) * 130 + 30
        } else {
            countOfCategoriesShowed = 4
            height = CGFloat (160)
        }
        userCategoriesCollectionView.reloadData()
        heightConstraint.constant = height
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
    
    
    func makingResponseGlobal (data: All) {
        count = data.count
        banners = data.banners
        regions = data.regions
        userCategories = data.userCategories
        articleCategories = data.articleCategories
        officials = data.officials
        followings = data.followings
    }
    
    
}


class Footer: UICollectionReusableView {
}

