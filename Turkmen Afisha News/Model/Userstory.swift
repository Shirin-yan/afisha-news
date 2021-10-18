//
//  Stories.swift
//  Turkmen Afisha News
//
//  Created by izi on 05.07.2021.
//

import Foundation

struct StoryofOfficial: Codable {
    var stories: [Story]
}


struct Story: Codable {
    var id: Int
    var image: String
    var viewCount: Int
    var likeCount: Int
    var isLike: Int?
    var shareCount: Int
    var createdAt: String
    var user: Official
}
