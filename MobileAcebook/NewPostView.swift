//
//  NewPostView.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 11/10/2023.
//

import SwiftUI

struct NewPostView: View {
    
    let postService: PostService
    @State var postMessage: String = "Enter new message"
    @State var username: String = "Test User"
    @State var errorMessage: String = ""
    @State private var goToFeed: Bool = false
    
    var body: some View {
        ZStack {
            AcebookBg()
            VStack {
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                
                Text("New Post").font(.custom(.bold, size: 36))
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                    .foregroundColor(Color("CTA"))
                    .bold()
                
                VStack {
                    HStack {
                        Text("\(username)")
                        Spacer()
                        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1473830394358-91588751b241?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                    TextEditor(text: $postMessage).padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/).foregroundColor(Color("CTA")).scrollContentBackground(.hidden).background(Color("Primary")).overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    ).cornerRadius(15)
                    Spacer(minLength: 20)
                    
                    Button(action: {
                        if postMessage == "" {
                            errorMessage = "No message entered"
                        } else {
                            
                            postService.newPost(message: postMessage, completion: { (message, error) in
                                
                                if let message = message {
                                    if message == "OK" {
                                        print(message)
                                        goToFeed = true
                                    } else {
                                        errorMessage = message
                                    }
                                } else if let error = error {
                                    print("Error: \(error)")
                                }
                            })
                        }
                    }, label: {
                        ButtonView(text: "Post").bold()
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
                }.frame(width: 300).padding(.all, 20).background(Color(.white)).cornerRadius(20)
                
                Spacer()
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(postService: PostService())
    }
}
