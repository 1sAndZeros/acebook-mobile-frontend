//
//  PostServiceProtocol.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 11/10/2023.
//

import Foundation

public protocol PostServiceProtocol {
    
    typealias newPostCallback = (String?, Error?) -> Void
    
    func newPost(message: String, completion: @escaping newPostCallback)
}
