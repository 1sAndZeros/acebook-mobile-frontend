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
                    .accessibilityIdentifier("welcomeText")

                VStack {
                    SignUpInputView(label: "Username", placeholder: "John Doe")
                    SignUpInputView(label: "Email", placeholder: "johndoe@example.com")
                    SignUpInputView(label: "Password", placeholder: "********")
                    SignUpInputView(label: "Confirm Pasword", placeholder: "********")
                }.padding(.leading, 60).padding(.vertical, 20).background(Color("Secondary"))

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
    
    var body: some View {
        HStack {
            Text(label).frame(width: 100, alignment: .leading)
            TextField(placeholder, text:$value)
        }
    }
}
