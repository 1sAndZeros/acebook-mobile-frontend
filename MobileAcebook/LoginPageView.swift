//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Roberto Quadraccia on 09/10/2023.
//

import SwiftUI

struct LoginPageView: View {
    let authService: AuthenticationService
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var goToFeed: Bool = false
    
    var body: some View {
        ZStack {
            AcebookBg()
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .accessibilityIdentifier("logo")
                    .padding(.top, 30)
                    .padding(.bottom, -100)
                Spacer()
                Text("Log In")
                    .font(.custom(.bold, size: 36))
                    .foregroundColor(Color("CTA"))
                    .bold()
                    .padding(.bottom, 40)
                HStack {
                    Label("Email:", systemImage: "envelope")
                        .frame(width: 120, alignment: .trailing)
                    TextField("Enter your email..", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).disableAutocorrection(true).autocapitalization(.none)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                HStack {
                    Label("Password:", systemImage: "lock")
                        .frame(width: 120, alignment: .trailing)
                    SecureField("Enter your password..", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).disableAutocorrection(true).autocapitalization(.none)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 30)
                if showAlert {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .opacity(showAlert ? 1 : 0)
                            }
                Button(action: {
                    if email.isEmpty && password.isEmpty {
                        errorMessage = "Please enter your email and password"
                        withAnimation {
                            showAlert = true
                        }
                    } else if email.isEmpty {
                        errorMessage = "Please enter your email"
                        withAnimation {
                            showAlert = true
                        }
                    } else if password.isEmpty {
                        errorMessage = "Please enter your password"
                        withAnimation {
                            showAlert = true
                        }
                    } else {
                        errorMessage = ""
                        authService.logIn(email: email, password: password, completion: { (token, error) in
                            
                            if token != nil {
                                goToFeed = true
                            } else {
                                showAlert = true
                                errorMessage = "Login details incorrect"
                            }
                        })
                    }
                }, label: {
                    ButtonView(text: "Login")
                }
                )
                NavigationLink(
                    destination: FeedPageView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                        isActive: $goToFeed)
                {
                    EmptyView()
                    }
                Spacer()
            }
        }
    }
}


struct LogInPageView_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthenticationService()
        LoginPageView(authService: authService)
    }
}
