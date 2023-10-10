//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 09/10/2023.
//

import SwiftUI

struct SignUpPageView: View {
    let authService: AuthenticationService
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var verifyPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Secondary"), Color("Primary"), Color("Primary")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .accessibilityIdentifier("makers-logo")
                    .padding(.top, 30)
                    .padding(.bottom, 50)
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("signup")

                VStack() {
                    SignUpTextInputView(value: $username, label: "Username: ", placeholder: "John Doe", icon: "person")
                    SignUpTextInputView(value: $email, label: "Email: ", placeholder: "johndoe@example.com", icon: "envelope")
                    SignUpPasswordInputView(value: $password, label: "Password: ", placeholder: "********", icon: "lock")
                    SignUpPasswordInputView(value: $verifyPassword, label: "Confirm Pasword: ", placeholder: "********", icon: "checkmark")
                }.frame(width: 350.0).padding(.leading, 10).padding(.vertical, 20)
                Text(errorMessage).frame(height: 25).padding(.bottom, 30).foregroundColor(.red)
                Button(action: {
                    if username.isEmpty {
                        errorMessage = "Please enter a username"
                        withAnimation {
                          showAlert = true
                        }
                    } else if email.isEmpty && password.isEmpty {
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
                          } else if verifyPassword.isEmpty {
                              errorMessage = "Please confirm your password"
                              withAnimation {
                                  showAlert = true
                              }
                          } else if password != verifyPassword {
                                errorMessage = "Passwords do not match"
                                withAnimation {
                                  showAlert = true
                                }
                          } else {
                              errorMessage = ""
                            // route to the next page
                              var newUser : User = User(username: username, email: email, password: password)
                              authService.signUp(user: newUser)
                          }
                        }, label: {
                          Text("Sign Up")
                            .foregroundColor(Color.white)
                            .font(.headline)
                        }
                        ).padding(.vertical, 15)
                          .padding(.horizontal, 30)
                          .background(Color("CTA"))
                          .foregroundColor(.white)
                          .cornerRadius(10)
                .accessibilityIdentifier("signUpButton")
                
                Spacer()
            }
            .frame(width: 500.0)
        }.background(Color("Primary"))
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthenticationService()
        SignUpPageView(authService: authService)
    }
}

struct SignUpTextInputView: View {
    
    @Binding var value: String
    let label: String
    let placeholder: String
    let icon: String
   
    var body: some View {
        HStack {
            Spacer()
            Label(label, systemImage: icon)
            .frame(width: 120, alignment: .trailing)
                TextField(placeholder, text:$value).textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
        }
    }
}

struct SignUpPasswordInputView: View {
    
    @Binding var value: String
    let label: String
    let placeholder: String
    let icon: String
   
    var body: some View {
        HStack {
            Spacer()
            Label(label, systemImage: icon)
            .frame(width: 120, alignment: .trailing)
                SecureField(placeholder, text:$value).textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
        }
    }
}

