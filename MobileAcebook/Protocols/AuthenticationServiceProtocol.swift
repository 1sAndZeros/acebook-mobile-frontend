//
//  AuthenticationServiceProtocol.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 01/10/2023.
//

public protocol AuthenticationServiceProtocol {
    
    typealias signUpCallback = (String?, Error?) -> Void
    typealias AuthCallBack = (String?, Error?) -> Void
    
    func signUp(user: User, completion: @escaping signUpCallback)
    func logIn(email: String, password: String, completion: @escaping AuthCallBack)
}
