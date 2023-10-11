//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    
    typealias AuthCallBack = (String?, Error?) -> Void
    
    func signUp(user: User) -> Bool
    func logIn(email: String, password: String, completion: @escaping AuthCallBack)
}
