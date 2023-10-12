//
//  PostService.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 11/10/2023.
//

import Foundation

class PostService: PostServiceProtocol {
    
    struct ApiResponse: Codable {
        var token: String
        var message: String
    }
    
    func newPost(message: String, completion: @escaping newPostCallback) {
        let json: [String: Any] = ["message": message]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let urlString = "http://localhost:8080/posts"
        guard let url = URL(string: urlString) else {
            // If the URL is invalid, call the completion block with an error.
            completion(nil, NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }
        
        let token = UserDefaults.standard.object(forKey: "token") as? String ?? "No token"
        print(token)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
}
