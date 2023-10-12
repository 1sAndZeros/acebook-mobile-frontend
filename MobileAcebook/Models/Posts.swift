//
//  Posts.swift
//  MobileAcebook
//
//  Created by Ani Singh on 11/10/2023.
//

import Foundation

public struct Posts: Codable {
    var posts: [Post]
    var token: String
    var user: User
}

public struct Post: Codable {
//    var likes: [String]
//    var comments: Int
    var _id: String
    var message: String
    var createdBy: String
    var createdAt: String
    var image: String
}

