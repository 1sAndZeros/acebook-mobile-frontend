//
//  LoginPageView.swift
//  MobileAcebook
//
//  Created by Roberto Quadraccia on 09/10/2023.
//

import SwiftUI

struct LoginPageView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color("Primary")
                .ignoresSafeArea()
            VStack {
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .accessibilityIdentifier("makers-logo")
                    .padding(.top, 30)
                    .padding(.bottom, -100)
                Spacer()
                Text("Log In")
                    .font(.largeTitle)
                    .foregroundColor(Color("Secondary"))
                    .bold()
                    .padding(.bottom, 40)
                HStack {
                    Label("Email:", systemImage: "envelope")
                        .frame(width: 120, alignment: .trailing)
                    TextField("Enter your email..", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                HStack {
                    Label("Password:", systemImage: "lock")
                        .frame(width: 120, alignment: .trailing)
                    TextField("Enter your password..", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 30)
                if showAlert {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .opacity(showAlert ? 1 : 0)
//                                    .withAnimation(.easeInOut(duration: 0.3))
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
                        // route to the next page
                    }
                }, label: {
                    Text("Log In")
                        .foregroundColor(Color.white)
                        .font(.headline)
                }
                ).padding(.vertical, 15)
                    .padding(.horizontal, 30)
                    .background(Color("CTA"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
        
}

#Preview {
    LoginPageView()
}
