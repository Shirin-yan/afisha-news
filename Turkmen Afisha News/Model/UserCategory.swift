//
//  Categories.swift
//  Turkmen Afisha News
//
//  Created by izi on 06.07.2021.
//

import Foundation

struct UserCategory: Codable {
    var id: Int
    var images: String?
    var tmName: String
    var enName: String
    var ruName: String
}

struct Image: Codable {
    var blueImage: String?
    var mobImage: String?
    var webImage: String?
}
