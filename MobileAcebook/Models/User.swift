//
//  User.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public struct Users: Codable {
    let user: User
    let token: String
}
public struct User: Codable {
    let _id: String
    let username: String
    let email: String
    let password: String
    let avatar: String
}
