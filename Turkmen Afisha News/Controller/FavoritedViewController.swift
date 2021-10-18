//
//  FavoritedViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 12.09.2021.
//

import UIKit

class FavoritedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var articleIndToPass: Int!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        if token == nil {
            showAlert(code: 1)
            spinner.stopAnimating()
        } else {
            GettingApi().getArticles(id: 0, offset: 0, isFavorited: true) { (res) in
                self.spinner.startAnimating()
                favoritedArticles = res.articles
                self.articlesCollectionView.delegate = self
                self.articlesCollectionView.dataSource = self
                self.spinner.stopAnimating()
                self.articlesCollectionView.isHidden = false
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell {
            cell.configureCell(article: favoritedArticles [indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height:230)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        articleIndToPass = indexPath.item
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "article") as? ArticlesViewController {
            vc.articleInd = articleIndToPass
            articles = favoritedArticles
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func selectingFavorited ( articles: [Article]) {
        articles.forEach { (article) in
            if article.isFavorite == 1 {
                favoritedArticles.append(article)
            }
        }
        
        if favoritedArticles.isEmpty == true {
            emptyLabel.isHidden = false
        }
    }
    
}
