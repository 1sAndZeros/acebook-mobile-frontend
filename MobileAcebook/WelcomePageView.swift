//
//  WelcomePageView.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

struct WelcomePageView: View {
        
        var body: some View {
            NavigationView {
            ZStack {
                AcebookBg()
                VStack {
                    Spacer()
                    
                    Text("Welcome to Acebook!")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                        .accessibilityIdentifier("welcomeText")
                    
                    Spacer()
                    
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .accessibilityIdentifier("makers-logo")
                    
                    Spacer()
                    NavigationLink {
                        let authService = AuthenticationService()
                        SignUpPageView(authService: authService)
                    } label: {
                        ButtonView(text: "Sign Up Here")
                    }
                    
                    NavigationLink {
                        let authService = AuthenticationService()
                        SignUpPageView(authService: authService)
                    } label: {
                        ButtonView(text: "Login Here")
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}

struct ButtonView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .padding(.vertical, 15)
            .padding(.horizontal, 30)
            .frame(minWidth: 200.0)
            .background(Color("CTA"))
            .foregroundColor(.white)
            .cornerRadius(10)
            .accessibilityIdentifier("signUpButton")
    }
}
