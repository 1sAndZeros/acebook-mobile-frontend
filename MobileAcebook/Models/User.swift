//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public struct Users: Codable {
    var user: User
    var token: String
}
public struct User: Codable {
    var _id: String
    var username: String
    var email: String
    var password: String
    var avatar: String
}
