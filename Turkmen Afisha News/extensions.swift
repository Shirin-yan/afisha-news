//
//  extensions.swift
//  Turkmen Afisha News
//
//  Created by izi on 23.07.2021.
//

import UIKit

extension UIViewController {
    func officialsofUserCategory(selectedCategoryInd: Int) {
        if officialsOfUserCategory != nil { officialsOfUserCategory.removeAll() }
        let id = userCategories[selectedCategoryInd].id
        if id != -1 {
            officials.forEach { (official) in
                let offCat = official.categories
                let offCount = offCat?.count ?? 0
                for i in 0..<offCount {
                    if offCat![i].id == id {
                        officialsOfUserCategory.append(official)
                    }
                }
            }
        } else {
            officialsOfUserCategory = officials
        }
    }
    
    func simpleAlert(title: String, message:String, someAction: @escaping () -> Void = { } ) {
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "OK", style: .default, handler: { (action) in
            someAction()
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    func searchClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "search") as! SearchResultsViewController
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func favoriteClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "favorite") as! FavoritedViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func settingsClicked () {
        let vc = storyboard?.instantiateViewController(withIdentifier: "settings") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func addClicked () {
        
        if token == nil {
            simpleAlert(title: "Attention", message: "To add News or Stories you should register or log in first.")
        } else {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
    
    func profileClicked () {
        if token == nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginVc") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            GettingApi().getOfficial(id: id) { (user) in
                selectedOfficial = user.user
                userBanner = user.banners
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "profileVc") as! UserProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func parsingStringArray (str: String!) -> [String] {
        var string = str!
        string = String (string.dropFirst(2))
        string = String(string.dropLast(2))
        return string.components(separatedBy: "\",\"")
    }
    
    func downloadImg (imgString: String) -> UIImage {
        let  imgUrl = URL (string: "http://tmafisha.com:3010/api" + imgString )
        let data = try? Data (contentsOf: imgUrl!)
        return UIImage(data: data!)!
    }
    
    func strInSelectedLang (lang: String, stingsToSelect: [String]) -> String {
        switch lang {
        case "en":
            return stingsToSelect[0]
            
        case "ru":
            return stingsToSelect[1]
            
        case "tm":
            return stingsToSelect[2]
            
        default:
            return ""
        }
    }
    
}

extension UICollectionViewCell {
    
    func downloadImg (imgString: String) -> UIImage {
        let  imgUrl = URL (string: "http://tmafisha.com:3010/api" + imgString )
        let data = try? Data (contentsOf: imgUrl!)
        return UIImage(data: data!)!
    }
    
    func parsingImgJson (jsonString: String!) -> String {
        let json = (jsonString).data(using: .utf8)!
        let imgString = (try? JSONDecoder().decode(Image.self, from: json).blueImage)!
        return imgString
    }
    
    func parsingStringArray (str: String!) -> [String] {
        var string = str!
        string = String (string.dropFirst(2))
        string = String(string.dropLast(2))
        return string.components(separatedBy: "\",\"")
    }
    
    func strInSelectedLang (lang: String, stingsToSelect: [String]) -> String {
        switch lang {
        case "en":
            return stingsToSelect[0]
            
        case "ru":
            return stingsToSelect[1]
            
        case "tm":
            return stingsToSelect[2]
            
        default:
            return ""
        }
    }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func changeFormatOfDate (inputFormat: String, outputFormat: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = inputFormat
        let date = dateformatter.date(from: self)
        dateformatter.dateFormat = outputFormat
        return dateformatter.string(from: date!)
    }
}

extension Date {
    func today(format : String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}


extension UIStackView {
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}




//extension Bundle {
//    private static var bundle: Bundle!
//
//    public static func localizedBundle() -> Bundle {
//        let appLang = UserDefaults.standard.string(forKey: "appLang") ?? "en"
//        let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
//        print (1234, appLang, path)
//        bundle = Bundle(path: path!)
//        return bundle
//    }
//
//    public static func setLanguage(lang: String) {
//        //UserDefaults.standard.set(lang, forKey: "appLang")
//        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
//        bundle = Bundle(path: path!)
//        print (12345, path)
//        }
//
//}


extension UIViewController {
    func showAlert (code: Int) {
        var title = ""
        var message = ""
        switch code {
        
        case 0:
            title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            message = strInSelectedLang(lang: appLang, stingsToSelect: ["You should Log in first.", "Сначала вы должны войти в ваш аккаунт.", "Ilki bilen akkaundyňyza girmeli."])
            simpleAlert(title: title, message: message)
            
        case 1:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["You should Log in first.", "Сначала вы должны войти в ваш аккаунт.", "Ilki bilen akkaundyňyza girmeli."])
            simpleAlert(title: title, message: message) { self.dismiss(animated: true, completion: nil)
            }
            
        case 2:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["To log out you need to log in.", "Что-бы выйти с аккаунта вам нужно сначала ввойти в него.", "Akkaundyňyzdan çykmak üçin siz ilki bilen girmeli."])
            simpleAlert(title: title, message: message)
            
        case 3:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["You have already logged in.", "Вы уже вошли в ваш аккаунт.", "Siz eýýäm akkaundyňyza girdiňiz."])
            simpleAlert(title: title, message: message)
            
        case 4:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["You have logged out.", "Вы вышли с аккаунта.", "Akkaundyňyzdan çykdyňyz."])
            simpleAlert(title: title, message: message)
        
        case 5:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Failure.", "Ошибка.", "Ýalňyşlyk."])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["Something went wrong.", "Что-то пошло не так.", "Ýalňyşlyk ýüze çykdy."])
            simpleAlert(title: title, message: message)
            
        case 6:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Success.", "Успешно.", "Üstünlik."])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["Your stories has been sent", "Ваши сторис отправлены.", "Siziň storisiňiz iberildi."])
            simpleAlert(title: title, message: message) {self.dismiss(animated: true, completion: nil) }

        case 7:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Success.", "Успешно.", "Üstünlik."])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["Your news has been sent", "Ваши новости отправлены.", "Siziň habaryňyz iberildi."])
            simpleAlert(title: title, message: message) {
                self.dismiss(animated: true, completion: nil)
            }
          
        case 8:
            let title = self.strInSelectedLang(lang: appLang, stingsToSelect: ["Success.", "Успешно.", "Üstünlik."])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["You have successfully logged in.", "Вход был выполнен успешно.", "Siz akkaundyňyza üstünlikli girdiňiz."])
            simpleAlert(title: title, message: message) {
                toReload = true
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        case 9:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["Username or Password is incorrect.", "Имя пользователья или пароль введены неправильно.", "Ulanyjynyň ady ýa-da açarsözi nädogry."])
            self.simpleAlert(title: title, message: message)
            
        case 10:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["You should fill all fields.", "Нужно заполнить все поля.", "Ähli meýdanlary doldurmaly."])
           simpleAlert(title: title, message: message)
        case 11:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Success.", "Успешно.", "Üstünlik."])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["Your feedback has been sent. Thank you for your feedback.", "Ваш отзыв был отправлен. Спасибо за ваш отзыв.", "Pikirleriňiz iberildi Pikirleriňiz üçin sag boluň."])
            simpleAlert(title: title, message: message)
            
        case 12:
            let title = self.strInSelectedLang(lang: appLang, stingsToSelect: ["Success.", "Успешно.", "Üstünlik."])
            let message = self.strInSelectedLang(lang: appLang, stingsToSelect: ["You have successfully registered.", "Вы успешно зарегистрировались.", "Siz üstünlikli hasaba alyndyňyz."])
            self.simpleAlert(title: title, message: message)
            
        case 13:
            let title = strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = strInSelectedLang(lang: appLang, stingsToSelect: ["Passwords are not same.", "Пароли не совпадают", "Açarsözler meňzeş däl."])
            simpleAlert(title: title, message: message)
        case 14:
            let title = self.strInSelectedLang(lang: appLang, stingsToSelect: ["Attention!", "Внимание!", "Üns beriň!"])
            let message = self.strInSelectedLang(lang: appLang, stingsToSelect: ["Username or phone number is already used.", "Имя пользователья или номер телефона уже имеются.", "Ulanyjynyň ady ýa-da telefon belgisi ulanylýar."])
            simpleAlert(title: title, message: message)
            
        case 100:
            simpleAlert(title: strInSelectedLang(lang: appLang, stingsToSelect: ["No maps.", "Карт не имеется", "Karta ýok."]), message: "") {
                self.navigationController?.popViewController(animated: true)
            }
            
        default:
            break
        }
        
        
    }
}
