//
//  FeedService.swift
//  MobileAcebook
//
//  Created by Ani Singh on 11/10/2023.
//

import Foundation

class FeedService {
    
    typealias FeedCallBack = (Posts?, Error?) -> Void
    
    func loadPosts(token:String, completion: @escaping FeedCallBack) -> Void {
        var request = URLRequest(url: URL(string: "http://localhost:8080/posts")!)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }            
            
            if let data = data {
                let decoder = JSONDecoder()
                if let posts = try?
                    decoder.decode(Posts.self, from: data) {
                    print(posts)
                    completion(posts, nil)
                } else {
                    completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
                    
                }
            }
        }
            task.resume()
    }
}

