//
//  All.swift
//  Turkmen Afisha News
//
//  Created by izi on 26.07.2021.
//

import Foundation

struct All: Codable {
    var count : Count
    var banners: [Banner]
    var regions: [Region]
    var userCategories: [UserCategory]
    var articleCategories: [ArticleCategory]
    var officials: [Official]
    var followings: [Int]?
}

struct Count: Codable {
    var articles: Int
    var followers: Int?
    var followings: Int?
}

struct Region: Codable {
    var id: Int
    var province: Int
    var name: String
}


