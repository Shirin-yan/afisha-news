//
//  Official.swift
//  Turkmen Afisha News
//
//  Created by izi on 29.07.2021.
//

import Foundation

struct Official: Codable {
    var id: Int
    var username: String
    var image: String?
    var note: String?
    var about: String?
    var contacts: String?
    var maps: String?
    var categories: [UserCategory]?
    var followerCount: Int?
    var followingCount: Int?
    var regions: [Region]
    var status: String
    var partnerType: String
}

struct Map: Codable {
    var title: String
    var lat: String
    var lng: String
}

