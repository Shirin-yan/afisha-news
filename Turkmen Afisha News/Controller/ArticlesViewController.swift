//
//  ArticlesViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 12.07.2021.
//

import UIKit
import ViewAnimator
import Alamofire

class ArticlesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var agoLbl: UILabel!
    @IBOutlet weak var articleView: UIView!
    @IBOutlet weak var articleImgesCollectionView: UICollectionView!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var createdDatelbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var viewForShareBtnClick: UIView!
    @IBOutlet weak var labelForShareBtnClick: UILabel!
 
    var articleInd : Int!
    var articleData: Article!
    var arrOfImg: [String]!
    var animation = AnimationType.from(direction: .right, offset: 30.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        articleView.animate(animations: [animation])
        articleData = articles[articleInd]
        arrOfImg = parsingStringArray(str: articleData.images)
        setupTheView()
        articleImgesCollectionView.delegate = self
        articleImgesCollectionView.dataSource = self
    }
    
    func setupTheView() {
        let date = stringToDate(stringDate: articleData.createdAt)
        agoLbl.text = agoLblText()
        regionLbl.text = selectedRegion
        if articleData.categories.isEmpty == false {
            let categorylbl = strInSelectedLang(lang: appLang, stingsToSelect: [articleData.categories[0].enName, articleData.categories[0].ruName, articleData.categories[0].tmName])
            categoryLbl.text = categorylbl
        } else {
            categoryLbl.text = ""
        }
        
        if articleData.isFavorite == 1 {
            favoriteBtn.setImage(UIImage(named: "favorited"), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
        }
        
        if articleData.isLike == 1 {
            likeBtn.setImage(UIImage(named: "liked"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(named: "like"), for: .normal)
        }
        
        viewsLbl.text = String (articleData.viewCount)
        likesLbl.text = String (articleData.likeCount)
        shareLbl.text = String (articleData.shareCount)
        titleLbl.text = articleData.title
        contentLbl.text = strInSelectedLang(lang: appLang, stingsToSelect: [articleData.enContent ?? "", articleData.ruContent ?? "", articleData.tmContent ?? ""])
        createdDatelbl.text = "\(dateToPrint(date: date))"
    }
    
    @IBAction func tmClicked(_ sender: Any) {
        contentLbl.text = articleData.tmContent
    }
    
    @IBAction func ruClicked(_ sender: Any) {
        contentLbl.text = articleData.ruContent
    }
    
    @IBAction func enClicked(_ sender: Any) {
        contentLbl.text = articleData.enContent
    }
    
    @IBAction func enlargeFontClicked(_ sender: UIButton!) {
        let titleFontSize = titleLbl.font.pointSize
        let contentFontSize = contentLbl.font.pointSize
        
        if titleFontSize < 27 {
            titleLbl.font = UIFont(name: "Arial", size: CGFloat (titleFontSize + 2) )!
            contentLbl.font = UIFont(name: "Arial", size: CGFloat (contentFontSize + 2))
        }
    }
    
    @IBAction func smallFontClicked(_ sender: UIButton!) {
        let titleFontSize = titleLbl.font.pointSize
        let contentFontSize = contentLbl.font.pointSize
        
        if titleFontSize > 17 {
            titleLbl.font = UIFont(name: "Arial", size: CGFloat (titleFontSize - 2) )!
            contentLbl.font = UIFont(name: "Arial", size: CGFloat (contentFontSize - 2))
        }
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        if token == nil {
            showAlert(code: 0)
        } else {
            if articles[articleInd].isLike != 1 {
                //// Dislike ucin, ol yagdayam bolup biler...
//                GettingApi().userAction(action: "like", count: -1, id: articles[articleInd].id) { (res) in
//                    self.inCaseSuccess(action: "like", count: -1)
//                }
//            } else {
                GettingApi().userAction(action: "liked", id: articles[articleInd].id) { (res) in
                    self.inCaseSuccess(action: "like", count: 1)
                }
            }
        }
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        if token == nil {
          showAlert(code: 0)
        } else {
            GettingApi().userAction(action: "share", id: articles[articleInd].id) { (res) in
                self.inCaseSuccess(action: "share", count: 1)
            }
        }
    }
    
    @IBAction func backForShareView(_ sender: Any) {
        viewForShareBtnClick.isHidden = true
    }
    
    @IBAction func favoritedClicked(_ sender: Any) {
        if token == nil {
            showAlert(code: 0)
        } else {
            if articles[articleInd].isLike != 1 {
                GettingApi().userAction(action: "favorite", id: articles[articleInd].id) { (res) in
                    self.inCaseSuccess(action: "favorite", count: -1)
                }
            } else {
                GettingApi().userAction(action: "favorite", id: articles[articleInd].id) { (res) in
                    self.inCaseSuccess(action: "favorite", count: 1)
                }
            }
        }
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        //previousArticle
        if articleInd>0 {
            articleInd -= 1
            viewForShareBtnClick.isHidden = true
            viewWillAppear(true)
            animation = AnimationType.from(direction: .left, offset: 30.0)
            articleImgesCollectionView.reloadData()
        }
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        //nextArticle
        if articleInd<articles.count - 1 {
            articleInd += 1
            viewWillAppear(true)
            animation = AnimationType.from(direction: .right, offset: 30.0)
            articleImgesCollectionView.reloadData()
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
    
    
    func agoLblText () -> String {
        var str = ""
        let now = stringToDate(stringDate: Date().today())
        
        let created = stringToDate(stringDate: articleData.createdAt)
        let diffs = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: created, to: now)
        if diffs.year?.description != "0" { str +=  diffs.year!.description + " year(s)"}
        if diffs.month?.description != "0" { str +=  diffs.month!.description + " month(s)"}
        if diffs.day?.description != "0" { str +=  diffs.day!.description + " day(s)"}
        if diffs.hour?.description != "0" && str == "" { str +=  diffs.hour!.description + " hours(s) "}
        if str == "" { str += diffs.minute!.description + " minites "}

        return str + " ago"
    }

    func stringToDate (stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: stringDate) {
            return date
        }
        return Date()
    }
    
    func dateToPrint (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    

    
    
    func inCaseSuccess (action: String, count: Int) {
        switch action {
        case "like":
            if count == 1 {
                likeBtn.setImage(UIImage(named: "liked"), for: .normal)
                articleData.isLike = 1
                articles[articleInd].isLike = 1
                articles[articleInd].likeCount += 1
                likesLbl.text = String (articles[articleInd].likeCount)
            }
//            else {
//                favoriteBtn.setImage(UIImage(named: "like"), for: .normal)
//                self.articleData.isLike = 0
//                articles[articleInd].isLike = 0
//                articles[articleInd].likeCount -= 1
//                likesLbl.text = String (articles[articleInd].likeCount)
//            }
            
            articles[articleInd].likeCount += 1
            likesLbl.text = String (articles[articleInd].likeCount)
            
        case "share":
            viewForShareBtnClick.isHidden = false
            labelForShareBtnClick.text = "tmafisha/articles\(articleData.id)"
            articles[articleInd].shareCount += 1
            shareLbl.text = "\(articles[articleInd].shareCount)"
            
        case "favorite":
            if count == 1 {
                favoriteBtn.setImage(UIImage(named: "favorited"), for: .normal)
                articleData.isFavorite = 1
                articles[articleInd].isFavorite = 1
            } else {
                favoriteBtn.setImage(UIImage(named: "favorite"), for: .normal)
                self.articleData.isFavorite = 0
                articles[articleInd].isFavorite = 0
            }
            
        default:
            break
        }
    }
    
    
}






extension ArticlesViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
            cell.configureCellOfArticle(img: arrOfImg[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: view.bounds.width, height: CGFloat(250))
    }
}













class CopyableLabel: UILabel {
    
    override public var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(showMenu(sender:))
        ))
    }
    
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    
    @objc func showMenu(sender: Any?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(copy(_:)))
    }
}
