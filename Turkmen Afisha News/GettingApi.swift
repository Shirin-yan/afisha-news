//
//  Api.swift
//  Turkmen Afisha News
//
//  Created by izi on 26.07.2021.
//

import Foundation
import Alamofire


class GettingApi: UIViewController {
    var inProcess: Bool! = false
    
    func getMainApi(complition:  @escaping (All) -> () ) {
        var regionss = ""
        selectedRegionIds.forEach { (id) in
            regionss = regionss + "regionId=\(id)&"
        }
        
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        var req = URLRequest (url: URL (string: uurrll + "/main/mobile?\(regionss)")!)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if token != nil {
            req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(All.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    
    
    
    func getArticles(id: Int, offset: Int, isFavorited: Bool = false, complition:  @escaping (Articles) -> () ) {
        inProcess = true
        var regionss = ""
        selectedRegionIds.forEach { (id) in
            regionss = regionss + "regionId=\(id)&"
        }
        
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        var req: URLRequest
        if isFavorited {
            req = URLRequest (url: URL (string: uurrll + "articles?categoryId=\(id)&filter=favorites&limit=10&offset=\(offset)\(regionss)")!)
        } else {
            req = URLRequest (url: URL (string: uurrll + "articles?categoryId=\(id)&limit=10&offset=\(offset)\(regionss)")!)
        }
        
        if token != nil {
            req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
                
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(Articles.self, from: jsonData)
                complition (parsedData)
                self.inProcess = false
            } catch {
                print ("Failed to decode \(error)")
                self.inProcess = false
            }
        }
    }
    
  
    func getStories(complition:  @escaping (StoryofOfficial) -> () ) {
        var regionss = ""
        selectedRegionIds.forEach { (id) in
            regionss = regionss + "regionId=\(id)&"
        }
        
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        var req = URLRequest (url: URL (string: uurrll + "stories?\(regionss)")!)
        if token != nil {
            req.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        } else {
            return
        }
                
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                self.showAlert(code: 5)
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
    
    
    
    func getSearchResults(keyword: String, complition:  @escaping (Articles) -> () ) {
        var regionss = ""
        selectedRegionIds.forEach { (id) in
            regionss = regionss + "regionId=\(id)&"
        }
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        guard let url = URL (string: uurrll + "articles?search=\(keyword)\(regionss)") else { return }
        let req = URLRequest (url: url)
        
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(Articles.self, from: jsonData)
                print (parsedData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    
    
    func getOfficial(id: Int, complition:  @escaping (OfficialResponse) -> () ) {
        var regionss = ""
        selectedRegionIds.forEach { (id) in
            regionss = regionss + "regionId=\(id)&"
        }
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        let req = URLRequest (url: URL (string: uurrll + "users/\(id)\(regionss)")!)
        
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(OfficialResponse.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    func getBanner(id: Int, complition:  @escaping (Banners) -> () ) {
        let serializer = DataResponseSerializer (emptyResponseCodes: Set([200,204,205]))
        
        var req = URLRequest (url: URL (string: uurrll + "banners?search=app_banner_page_\(id)")!)
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        AF.request(req).uploadProgress { progress in }.response(responseSerializer: serializer){ response in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(Banners.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    
    
    
    
    func followUnfollowRequest (officialId: Int, toFollow: Bool, complition:  @escaping (LoginResponse) -> () ){
        var str = ""
        if toFollow {
            str = uurrll + "users/\(officialId)/follow"
        } else {
            str = uurrll + "users/\(officialId)/unfollow"
        }
        var request = URLRequest(url: URL(string: str)!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        AF.request(request).uploadProgress { progress in }.response { response in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                
                let parsedData = try jsonDecoder.decode(LoginResponse.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    
    
    func userAction (type: String = "article", action: String, count: Int = 1, id: Int, complition:  @escaping (LoginResponse) -> () ) {
        let body = "{\r\n\"type\": \"\(type)\",\r\n\"action\": \"\(action)\",\r\n    \"relId\": \(id),\r\n    \"count\": \(count)\r\n}"
        let postData = body.data(using: .utf8)
        var request = URLRequest(url: URL(string: uurrll + "user-actions")!)
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        AF.request(request).uploadProgress { (progres) in
        }.responseJSON(completionHandler: { (response) in
            if let error = response.error {
                self.showAlert(code: 5)
                debugPrint(error)
                return
            }
           
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(LoginResponse.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        })
    }
     
    func loginRegister (data: [String: String ], toLogin: Bool, toRecover: Bool = false,  complition:  @escaping (LoginResponse) -> () ) {
        var request: URLRequest!
        var body: String!
        
        if toLogin {
            body = "{\r\n\"username\": \"\(data["username"] ?? "" )\",\r\n\"password\":\"\(data["password"] ?? "")\"\r\n}"
            request = URLRequest(url: URL(string: "http://tmafisha.com:3010/api/v1/login")!)
        } else {
            body = "{\r\n\"username\": \"\(data["username"]!)\",\r\n\"phoneNumber\": \"\(data["phoneNumber"]!)\",\r\n \"password\": \"\(data["password"]!)\"\r\n}"
            if toRecover {
                    request = URLRequest(url: URL(string: "http://tmafisha.com:3010/api/v1/recover-password")!)
                } else {
                    request = URLRequest(url: URL(string: "http://tmafisha.com:3010/api/v1/register")!)
                }
        }
        
        let postData = body.data(using: .utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        
        AF.request(request).response { [self] (response) in
            if let error = response.error {
                showAlert(code: 5)
                debugPrint(error)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(LoginResponse.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
    
    func doesNotExist (data: [String: String], complition: @escaping (UserCheckerResponse) -> () ){
        let body = "{\r\n\"username\": \"\(data["username"]!)\",\r\n\"phoneNumber\": \"\(data["phoneNumber"]!)\"\r\n}"

        let postData = body.data(using: .utf8)
        var request = URLRequest(url: URL(string: "http://tmafisha.com:3010/api/v1/user-checker")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        
        AF.request(request).uploadProgress { (progres) in
        }.response { (response) in
            if let error = response.error {
                debugPrint(error)
                return
            }
            
            guard let jsonString = String (bytes: response.data!, encoding: .utf8) else { return  }
            guard let jsonData = jsonString.data(using: .utf8) else { return }
            let jsonDecoder = JSONDecoder ()
            do {
                let parsedData = try jsonDecoder.decode(UserCheckerResponse.self, from: jsonData)
                complition (parsedData)
            } catch {
                print ("Failed to decode \(error)")
            }
        }
    }
}




