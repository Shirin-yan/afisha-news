//
//  Constants.swift
//  Turkmen Afisha News
//
//  Created by izi on 29.07.2021.
//

import Foundation

var appLang = "ru"
var uurrll = "http://tmafisha.com:3010/api/v1/" 
var banners: [Banner] = []
var articleBanners: [Banner] = []
var articleCatBanners: [Banner] = []
var officialsBanners: [Banner] = []
var userBanner: [Banner] = []

var count : Count!

var stories: [Story]!
var userStories: [Story]! = []
var userStoryfromProfile: [Story]! = []
var selectedStories: Int!


var regions: [Region]!
var selectedRegionIds: [Int]! = []
var selectedRegion: String! = "Ashgabat"

var userCategories: [UserCategory]!
var articleCategories: [ArticleCategory]!

var officials: [Official]!
var officialsOfUserCategory: [Official]! = officials

var followings: [Int]?
var selectedOfficial: Official!
var mapsOfSelectedOfficial: [Map]!
var selectedMap: Int! = 0
var contactsFiltered: [String] = []
var phoneNumbers: [String] = []

var arrOfImg: [String]!

var articles: [Article]!
var favoritedArticles: [Article]!
var idArticleCat: Int!

var token: String!
var status: Int!
var id: Int!

var officialCellToColor: Int!
var articleCellToColor: Int!
var toReload = false


