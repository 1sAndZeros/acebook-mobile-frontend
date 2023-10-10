//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User) -> Bool {
        // Logic to call the backend API for signing up
        var request = URLRequest(url: URL(string: "http://localhost:8080/tokens")!)
        request.httpMethod = "POST"
        request.httpBody = "email=\(user.email)".data(using: .utf8)
        request.httpBody = "password=\(user.password)".data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle response here
        }
        task.resume()
        return true // placeholder
    }
}
