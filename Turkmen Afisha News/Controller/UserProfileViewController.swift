//
//  UserProfileViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 15.07.2021.
//

import UIKit
import Alamofire

class UserProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var articleIndToPass: Int!
    var articlesOfOfficial: [Article]!
    var storiesOfOfficial: [Story]!
    var height: CGFloat!
    
    @IBOutlet weak var followingslbl: UILabel!
    @IBOutlet weak var followerslbl: UILabel!
    @IBOutlet weak var newsLbl: UILabel!
    @IBOutlet weak var newsCount: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var storiesView: UIView!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    @IBOutlet weak var heightConstraintofCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var userTypeIcon: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userRegion: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var subscribeBtn: UIButton!
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsLbl.text = strInSelectedLang(lang: appLang, stingsToSelect: ["News", "Новости", "Täzelikler"])
        followerslbl.text = strInSelectedLang(lang: appLang, stingsToSelect: ["followers", "подписчики", "yzarlaýanlar"])
        followingslbl.text = strInSelectedLang(lang: appLang, stingsToSelect: ["followings", "подписки", "yzarlaýanlarym"])
        userImg.layer.cornerRadius = 50
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        
        setupProfile()
        
        
        filteringContactsStr(contacts: parsingStringArray(str: selectedOfficial.contacts))
        getArticlesOfOfficial { [self] (res) in
            articlesOfOfficial = res.articles
            if (articlesOfOfficial?.count == 0) || (articlesOfOfficial == nil) {
                newsView.isHidden = true
                print (123, true)
                print (articlesOfOfficial.count)
            } else {
                print (123, false)
                newsView.isHidden = false
                print (articlesOfOfficial.count)
                articlesCollectionView.delegate = self
                articlesCollectionView.dataSource = self
                heightConstraintofCollectionView.constant = CGFloat(res.articles.count * 160)
                
            }
            spinner.stopAnimating()
        }
        
        
        getStoriesOfOfficial { [self] (res) in
            storiesOfOfficial = res.stories
            if (storiesOfOfficial?.count == 0) || (storiesOfOfficial == nil) {
               storiesView.isHidden = true
                print (1234, true)
            } else {
                print (1234, false)
                storiesView.isHidden = false
                self.storiesCollectionView.delegate = self
                self.storiesCollectionView.dataSource = self
            }
            
        }
        
        
    }
    
    func setupProfile () {
        
        
        userImg.image = downloadImg (imgString: selectedOfficial.image!)
        username.text = selectedOfficial.username
        userStatus.text = selectedOfficial.note
        userRegion.text = "Region will be here"
        if selectedOfficial.regions.isEmpty == true {
            userRegion.text = "Ashgabat"
        } else {
            userRegion.text = selectedOfficial.regions[0].name
        }
        userTypeIcon.setImage(UIImage(named: userStatusIconName()), for: .normal)
        followingCount.text = "\(selectedOfficial.followingCount!)"
        followersCount.text = "\(selectedOfficial.followerCount!)"
        
        if followings?.contains(selectedOfficial.id) == true {
            subscribeBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else {
            subscribeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
        }
    }
    
    
    func filteringContactsStr (contacts: [String]) {
        contacts.forEach { (contact) in
            if contact.starts(with: "+993") {
                phoneNumbers.append(contact)
            } else if contact.isEmpty == false {
                contactsFiltered.append(contact)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannersCollectionView:
            return userBanner.count
            
        case storiesCollectionView:
            return storiesOfOfficial.count
            
        case articlesCollectionView:
            return articlesOfOfficial.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        
        case bannersCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                cell.configureCell(banner: userBanner[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
            
            
        case storiesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storiesCell", for: indexPath) as? StoriesCell {
                cell.configureCell(storyImg: storiesOfOfficial[indexPath.item].image)
                return cell
            }
            return UICollectionViewCell()
            
        case articlesCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell {
                cell.configureCell(article: articlesOfOfficial [indexPath.item])
                return cell
            }
            
            return UICollectionViewCell()
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannersCollectionView:
            return CGSize (width: collectionView.frame.width, height: CGFloat(250))
            
        case storiesCollectionView:
            return CGSize (width: 80, height: 80)
            
        case articlesCollectionView:
            return CGSize (width: collectionView.frame.width, height: 150)
        default:
            return CGSize (width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case storiesCollectionView:
            selectedStories = indexPath.item
            userStoryfromProfile = storiesOfOfficial
            if let vc = storyboard?.instantiateViewController(withIdentifier: "stories") as? StoriesViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
            
        case articlesCollectionView:
            articleIndToPass = indexPath.item
            if let vc = storyboard?.instantiateViewController(withIdentifier: "article") as? ArticlesViewController {
                vc.articleInd = articleIndToPass
                navigationController?.pushViewController(vc, animated: true)
            }
                
        default:
            break
        }
    }
    
    
    
    @IBAction func subscribeClicked(_ sender: Any) {
        let id = selectedOfficial.id
        if token != nil {
            if subscribeBtn.backgroundColor == #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1) {
                GettingApi().followUnfollowRequest(officialId: id, toFollow: true) { (response) in
                    if response.success {
                        followings?.append(id)
                        self.subscribeBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    }
                }
                
            } else {
                GettingApi().followUnfollowRequest(officialId: id, toFollow: false) { (response) in
                    if response.success {
                        followings = followings?.filter{ $0 != id}
                        self.subscribeBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
                    }
                }
            }
        } else {
            showAlert(code: 0)
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
    
    func userStatusIconName () -> String {
        var str = ""
        if selectedOfficial.status == "official" {
            str = "profile-official"
        } else {
            switch selectedOfficial.partnerType {
            case "silver":
                str = "profile-silver-partner"
                
            case "platinum":
                str = "profile-platinum-partner"
                
            case "gold":
                str = "profile-gold-partner"
            
            default:
                break
            }
        }
        return str
    }
}


extension UserProfileViewController {
    
    func getArticlesOfOfficial(complition:  @escaping (Articles) -> () ) {
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        let req = URLRequest (url: URL (string: "http://tmafisha.com:3010/api/v1/articles?userId=\(selectedOfficial.id)")!)

        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(Articles.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    
    func getStoriesOfOfficial(complition:  @escaping (StoryofOfficial) -> () ) {
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        var req = URLRequest (url: URL (string: "http://tmafisha.com:3010/api/v1/stories?userId=\(selectedOfficial.id)")!)
        if token != nil {
            req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization") }
                
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
        
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(StoryofOfficial.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
}
