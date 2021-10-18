//
//  ArticlesViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 08.07.2021.
//

import UIKit

class ArticlesSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var offset: Int = 0
    var articleIndToPass: Int!
    var height: CGFloat! = 0
    let width = UIScreen.main.bounds.width
    var isLoading: Bool = false
    
    @IBOutlet weak var scrollVieww: UIScrollView!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var articleCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    @IBOutlet weak var heightOfArticlesCollectionView: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollVieww.delegate = self
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        
        articleCategoriesCollectionView.delegate = self
        articleCategoriesCollectionView.dataSource = self
        
        articlesCollectionView.delegate = self
        articlesCollectionView.dataSource = self
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannersCollectionView:
            return articleBanners.count
        case articleCategoriesCollectionView:
            return articleCategories.count
        case articlesCollectionView:
            height = 0
            return articles.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannersCollectionView:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                    cell.configureCell(banner: articleBanners[indexPath.item])
                    return cell
                }
                return UICollectionViewCell()
            
            
        case articleCategoriesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCategoryTitleCell", for: indexPath) as? ArticleCategoryCell {
                let toColor = indexPath.item == articleCellToColor
                cell.configureCellTitleOnly(articleCategory: articleCategories[indexPath.item], toColor: toColor)
                return cell
            }
            return UICollectionViewCell()
            
            
        case articlesCollectionView:
            if indexPath.item % 5 != 0 {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell {
                    cell.configureCell(article: articles [indexPath.item])
                    height = height + 150
                    return cell
                } } else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCellBig", for: indexPath) as? ArticleCell {
                    cell.configureCell(article: articles [indexPath.item])
                    return cell
                } }
            return UICollectionViewCell()
        
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannersCollectionView:
            return CGSize (width: width, height: 230)
            
        case articleCategoriesCollectionView:
            return CGSize (width: width/3, height:  CGFloat(70))
            
        case articlesCollectionView:
            if indexPath.item % 5 != 0 {
                height = height + 155
                heightOfArticlesCollectionView.constant = height
                return CGSize(width: width, height:150)
            } else {
                height = height + 235
                heightOfArticlesCollectionView.constant = height
                return CGSize(width: width, height:230)
            }
            
        default:
            break
        }
        
        return CGSize(width: 0, height:0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        
        case articleCategoriesCollectionView:
            articleCellToColor = indexPath.item
            articleCategoriesCollectionView.reloadData()
            
            idArticleCat = articleCategories[indexPath.item].id
            GettingApi().getArticles(id: idArticleCat, offset: 0) { (res) in
                articles = res.articles
                self.articlesCollectionView.reloadData()
            }
        
            height = 0
             
            
        case articlesCollectionView:
            articleIndToPass = indexPath.row
            performSegue(withIdentifier: "toArticles", sender: self)
            
        default:
            return 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ArticlesViewController {
            vc.articleInd = articleIndToPass
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.contentSize.height - scrollView.frame.height + 50 {
            offset += 10
            if GettingApi().inProcess == false {
                GettingApi().getArticles(id: idArticleCat, offset: offset) { (res) in
                    print (123, articles.count)
                    articles.append(contentsOf: res.articles)
                    print (123, articles.count)
                    print (123, res.articles.count)
                    print (123, res.articles)
                    self.articlesCollectionView.reloadData()
                }
            }
            
        }
    }
    

    
    @IBAction func favoriteClicked(_ sender: Any) {
        favoriteClicked()
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        searchClicked()
    }
    
    @IBAction func settingsClicked(_ sender: UIButton) {
        settingsClicked()
    }
    
    @IBAction func profileClicked(_ sender: Any) {
        profileClicked()
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        addClicked()
    }
    
}



extension ArticlesSelectionViewController {
    //footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView == articlesCollectionView {
            return CGSize (width: width, height: 50)
        }
        return CGSize (width: 0, height: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == articlesCollectionView {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! Footer
            return footer
        }
        return UICollectionReusableView()
    }
}
