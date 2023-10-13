//
//  UserService.swift
//  MobileAcebook
//
//  Created by Roberto Quadraccia on 12/10/2023.
//

import Foundation

class UserService {
    
    typealias UserCallBack = (Users?, Error?) -> Void
    
    func getUser(token:String, completion: @escaping UserCallBack) -> Void {
        var request = URLRequest(url: URL(string: "http://localhost:8080/users")!)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            
            if let data = data {
                let decoder = JSONDecoder()
                if let users = try?
                    decoder.decode(Users.self, from: data) {
                    print(users)
                    completion(users, nil)
                } else {
                    completion(nil, NSError(domain: "Invalid data", code: 500, userInfo: nil))
                    
                }
            }
        }
            task.resume()
    }
}


