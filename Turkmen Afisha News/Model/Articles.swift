//
//  Articles.swift
//  Turkmen Afisha News
//
//  Created by izi on 29.07.2021.
//

import Foundation

struct Articles: Codable {
    var articles: [Article]
}


struct Article: Codable {
    var id: Int
    var images: String
    var title: String
    var enContent: String?
    var tmContent: String?
    var ruContent: String?
    var createdAt: String
    var viewCount: Int
    var likeCount: Int
    var shareCount: Int
    var isFavorite: Int?
    var isLike: Int?
    var categories: [ArticleCategory]
}
