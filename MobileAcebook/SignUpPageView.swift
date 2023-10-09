//
//  SignUpPageView.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 09/10/2023.
//

import SwiftUI

struct SignUpPageView: View {
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var verifyPassword: String = ""
    
    var body: some View {
        ZStack {
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
                    SignUpInputView(label: "Username: ", placeholder: "John Doe", icon: "person")
                    SignUpInputView(label: "Email: ", placeholder: "johndoe@example.com", icon: "envelope")
                    SignUpInputView(label: "Password: ", placeholder: "********", icon: "lock")
                    SignUpInputView(label: "Confirm Pasword: ", placeholder: "********", icon: "checkmark")
                }.frame(width: 350.0).padding(.leading, 10).padding(.vertical, 20)
                Text("Error Message goes here").frame(height: 25).padding(.bottom, 30).foregroundColor(.red)
                Button("Sign Up") {
                    // TODO: sign up logic
                }
                .accessibilityIdentifier("signUpButton")
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                .background(Color("CTA"))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .frame(width: 500.0)
        }.background(Color("Primary"))
    }
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
    }
}

struct SignUpInputView: View {
    
    @State var value: String = ""
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
