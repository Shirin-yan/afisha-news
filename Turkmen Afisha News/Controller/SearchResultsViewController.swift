//
//  SearchResultsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 10.09.2021.
//

import UIKit

class SearchResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLbl: UILabel!
    
    var articleIndToPass: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articles = []
        self.articlesCollectionView.delegate = self
        self.articlesCollectionView.dataSource = self
        self.searchBar.delegate = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell {
            cell.configureCell(article: articles [indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height:150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        articleIndToPass = indexPath.item
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "article") as? ArticlesViewController {
            vc.articleInd = articleIndToPass
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    func searching (keyword: String)  {
        GettingApi().getSearchResults(keyword: keyword) { (res) in
            articles = res.articles
            if articles.isEmpty != true {
                self.articlesCollectionView.isHidden = false
                self.articlesCollectionView.reloadData()
                self.noResultsLbl.isHidden = true
            } else {
                self.articlesCollectionView.isHidden = true
                self.noResultsLbl.isHidden = false
            }
        }
    }
    
    
    @IBAction func searchClicked(_ sender: Any) {
        searching(keyword: searchBar.text! )
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

