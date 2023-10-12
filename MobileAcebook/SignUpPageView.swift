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
    @State var avatar: String = ""
    @State var verifyPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var goToLogin: Bool = false
    
    var body: some View {
        ZStack {
            AcebookBg()
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
                    .foregroundColor(Color("CTA"))
                    .bold()
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
                    errorMessage = validForm(username: username, password: password, email: email, verifyPassword: verifyPassword)
                    if errorMessage == "OK" {
                        errorMessage = ""
                        // route to the next page
                        let newUser : User = User(_id: "", username: username, email: email, password: password, avatar: avatar)
                        authService.signUp(user: newUser, completion: { (message, error) in
                            // This block is the completion block (JokeCallback).
                            
                            if let message = message {
                                if message == "OK" {
                                    // GO TO LOGIN PAGE
                                    print(message)
                                    goToLogin = true
                                } else {
                                    errorMessage = message
                                }
                            } else if let error = error {
                                print("Error: \(error)")
                            }
                        })
                    }
                }, label: {
                          ButtonView(text: "Sign Up")
                        }
                        )
                NavigationLink(
                    destination: LoginPageView(authService: AuthenticationService())
                                        .navigationBarTitle("")
                                        .navigationBarHidden(true),
                                    isActive: $goToLogin
                                ) {
                                    EmptyView()
                                }
                
                Spacer()
            }
        }
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthenticationService()
        SignUpPageView(authService: authService)
    }
}

func validForm(username: String, password: String, email: String, verifyPassword: String) -> String {
    if username.isEmpty {
        return "Please enter a username"
    } else if email.isEmpty {
        return "Please enter your email"
    } else if password.isEmpty {
        return "Please enter your password"
    } else if verifyPassword.isEmpty {
        return "Please confirm your password"
    } else if password != verifyPassword {
        return "Passwords do not match"
    } else {
        return "OK"
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
                TextField(placeholder, text:$value).textFieldStyle(RoundedBorderTextFieldStyle()).disableAutocorrection(true).autocapitalization(.none)
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
                SecureField(placeholder, text:$value).textFieldStyle(RoundedBorderTextFieldStyle()).disableAutocorrection(true).autocapitalization(.none)
            Spacer()
        }
    }
}
