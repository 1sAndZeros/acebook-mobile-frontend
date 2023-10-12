//
//  AuthenticationService.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
    
    struct LogInResponse: Codable {
        var token: String
        var message: String
    }

    
    struct ApiData: Codable {
        var message: String
    }
    
    func signUp(user: User, completion: @escaping signUpCallback) {
        let json: [String: Any] = ["email": user.email, "password": user.password, "username": user.username]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let urlString = "http://localhost:8080/users"
        guard let url = URL(string: urlString) else {
            // If the URL is invalid, call the completion block with an error.
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if there was an error in the data task.
            if let error = error {
                // Call the completion block with the error.
                completion(nil, error)
                return
            }
            
            // Parse the fetched data to a String.
            if let data = data, let apiJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let message = apiJSON["message"] as? String {
                // Call the completion block with the message.
                completion("\(message)", nil)
            } else {
                // If data parsing fails, call the completion block with an error.
                completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
            }
        }
        task.resume()
    }
    
    func logIn(email: String, password: String, completion: @escaping AuthCallBack) {
        
        let json: [String: Any] = ["email": email, "password": password,]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let urlString = "http://localhost:8080/tokens"
        guard let url = URL(string: urlString) else {
            // If the URL is invalid, call the completion block with an error.
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if there was an error in the data task.
            if let error = error {
                // Call the completion block with the error.
                completion(nil, error)
                return
            }
            // Parse the fetched data to a String.
            if let data = data, let apiJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let token = apiJSON["token"] as? String {
                // Call the completion block with the joke.
                UserDefaults.standard.set(token, forKey: "token")
                //                                   let token = UserDefaults.standard.string(forKey: "token") ?? nil
                completion("\(token)", nil)
            } else {
                // If data parsing fails, call the completion block with an error.
                completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
            }
            
            //                if let data = data {
            //                let decoder = JSONDecoder()
            //                if let LogInResponse = try? decoder.decode(LogInResponse.self, from: data) {
            //                    UserDefaults.standard.set(LogInResponse.token, forKey: "token")
            //                    let token = UserDefaults.standard.string(forKey: "token") ?? "No token found"
            //
            
        }
        task.resume()
    }
    
}
