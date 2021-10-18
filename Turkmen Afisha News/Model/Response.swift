//
//  File.swift
//  Turkmen Afisha News
//
//  Created by izi on 14.08.2021.
//

import Foundation

struct LoginResponse: Codable {
    var success: Bool
    var token: String?
    var user: LoginUser?
}

struct UserCheckerResponse: Codable {
    var username: Bool
    var phoneNumber: Bool
}

struct LoginUser: Codable {
    var id: Int
    var status: Int
}


struct OfficialResponse: Codable {
    var success: Bool
    var banners: [Banner]
    var user: Official
}

struct Banners: Codable {
    var banners: [Banner]
}
