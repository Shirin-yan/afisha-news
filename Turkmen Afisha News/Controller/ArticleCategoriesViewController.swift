//
//  NewsCategoriesViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 07.07.2021.
//

import UIKit

class ArticleCategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var newsCategoryToPass : String!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var articleCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var articleCategoriesHeightConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        
        articleCategoriesHeightConstraint.constant = CGFloat (articleCategories.count * 170) + 40
        articleCategoriesCollectionView.delegate = self
        articleCategoriesCollectionView.dataSource = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannersCollectionView:
            return articleCatBanners.count
            
        case articleCategoriesCollectionView:
            return articleCategories.count
        
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannersCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                cell.configureCell(banner: articleCatBanners[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
        case articleCategoriesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCategoryCell", for: indexPath) as? ArticleCategoryCell  {
                cell.configureCell(articleCategory: articleCategories[indexPath.item])
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
        case bannersCollectionView:
            return CGSize (width: collectionView.frame.width, height: CGFloat(250))
        case articleCategoriesCollectionView:
            return CGSize (width: collectionView.frame.width, height: CGFloat(165))
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        spinner.startAnimating()
        idArticleCat = articleCategories[indexPath.item].id
        articleCellToColor = indexPath.item
        GettingApi().getArticles(id: idArticleCat, offset: 0) { (res) in
            articles = res.articles
            self.spinner.stopAnimating()
            self.performSegue(withIdentifier: "toArticlesSelection", sender: self)
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
