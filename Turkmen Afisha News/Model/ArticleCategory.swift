//
//  NewsCategories.swift
//  Turkmen Afisha News
//
//  Created by izi on 08.07.2021.
//

import Foundation

struct ArticleCategory: Codable {
    var id: Int
    var images: String?
    var tmName: String
    var enName: String
    var ruName: String
    var articleCount: Int?
}
