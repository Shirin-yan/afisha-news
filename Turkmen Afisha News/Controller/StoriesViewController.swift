//
//  StoriesViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 19.09.2021.
//

import UIKit
import ViewAnimator

class StoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var viewToAnimate: UIView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var whenPosted: UILabel!
    @IBOutlet weak var storyImg: UIImageView!
    @IBOutlet weak var dashesCollectionView: UICollectionView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var linkLbl: UILabel!
    
    var animation = AnimationType.from(direction: .right, offset: 30.0)
    var width = UIScreen.main.bounds.width
    var storiesCount = 0
    var storyInd = 0
    var user = userStories[selectedStories].user
    var storiesOfUser: [Story]! = []
    var fromProfile: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        countLbl.layer.cornerRadius = 10
        dashesCollectionView.delegate = self
        dashesCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        storyInd = -1
        storiesOfUser = []
        
        if fromProfile {
            user = userStoryfromProfile[selectedStories].user
            storiesOfUser = [userStoryfromProfile[selectedStories]]
            storiesCount = storiesOfUser.count
        } else {
            user = userStories[selectedStories].user
            storiesOfUser = stories.filter { $0.user.id == user.id }
            storiesCount = storiesOfUser.count
        }
        
        viewToAnimate.animate(animations: [animation])
        UserImage.image = downloadImg(imgString: user.image ?? "")
        UserName.text = user.username
        showStory(forward: true)
    }
    

    @IBAction func leftTap(_ sender: Any) {
        if storyInd >= 1 { showStory(forward: false) }
    }
    
    @IBAction func rightTap(_ sender: Any) {
        if storyInd < storiesCount - 1 { showStory(forward: true) }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func swipeRight(_ sender: Any) {
        //previous
        
        if selectedStories > 0 {
            selectedStories -= 1
            viewWillAppear(true)
            animation = AnimationType.from(direction: .left, offset: 30.0)
            dashesCollectionView.reloadData()
        }
        
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        //next
        
        if fromProfile {
            if selectedStories + 1 < userStoryfromProfile.count - 1 {
                selectedStories += 1
                viewWillAppear(true)
                animation = AnimationType.from(direction: .right, offset: 30.0)
                dashesCollectionView.reloadData()
            }
        } else {
            if selectedStories + 1 < userStories.count - 1 {
                selectedStories += 1
                viewWillAppear(true)
                animation = AnimationType.from(direction: .right, offset: 30.0)
                dashesCollectionView.reloadData()
            }
        }
        
        
    }
    
    
    func showStory(forward: Bool) {
        if forward { storyInd += 1 } else { storyInd -= 1 }
        linkLbl.text = uurrll + "stories/" + storiesOfUser[storyInd].image
        countLbl.text = "\(storiesCount - storyInd)"
        whenPosted.text = agoLblText()
        storyImg.image = downloadImg(imgString: storiesOfUser[storyInd].image )
        viewCount.text = "\(storiesOfUser[storyInd].viewCount)"
        likeCount.text = "\(storiesOfUser[storyInd].likeCount)"
        if storiesOfUser[storyInd].isLike != 1 {
            likeBtn.setImage(UIImage(named: "heart"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(named: "heart-full"), for: .normal)
        }
        dashesCollectionView.reloadData()
    }

    @IBAction func likeClicked(_ sender: Any) {
        if storiesOfUser[storyInd].isLike != 1 {
//            GettingApi().userAction(type: "stories", action: "like", count : -1, id: storiesOfUser[storyInd].id) { [self] (res) in
//                if res.success {
//                    likeBtn.setImage(UIImage (named: "heart"), for: .normal)
//                    storiesOfUser[storyInd].likeCount -= 1
//                    likeCount.text = "\(storiesOfUser[storyInd].likeCount)"
//                }
//            }
//        } else {
            GettingApi().userAction(type: "stories", action: "like", id: storiesOfUser[storyInd].id) { [self] (res) in
                if res.success {
                    likeBtn.setImage(UIImage (named: "filled-heart"), for: .normal)
                    storiesOfUser[storyInd].likeCount += 1
                    likeCount.text =  "\(storiesOfUser[storyInd].likeCount)"
                }
            }
        }
    }
    
    
    
    func agoLblText () -> String {
        var str = ""
        let now = stringToDate(stringDate: Date().today())
        let created = stringToDate(stringDate: storiesOfUser[storyInd].createdAt)
        
        let diffs = Calendar.current.dateComponents([.day, .hour, .minute], from: created, to: now)
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
    
}



extension StoriesViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        if indexPath.item != storyInd {
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        } else {
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wid = width / CGFloat(storiesCount)
        return CGSize (width: wid - 2, height: CGFloat(3))
    }
}
