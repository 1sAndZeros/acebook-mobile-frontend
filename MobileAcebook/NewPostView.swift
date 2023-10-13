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
    @State var user: User
    @State var errorMessage: String = ""
    @State private var goToFeed: Bool = false
    
    var body: some View {
        ZStack {
            AcebookBg()
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .accessibilityIdentifier("logo")
                
                Text("New Post").font(.custom(.bold, size: 36))
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("welcomeText")
                    .foregroundColor(Color("CTA"))
                    .bold()
                
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: user.avatar)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        Text("\(user.username)")
                        Spacer()
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
                        Image(systemName: "square.and.pencil")
                            .frame(width: 70, height: 70)
                            .imageScale(.large)
                            .background(Color("CTA"))
                            .foregroundColor(Color("Primary"))
                            .clipShape(Circle())
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
        NewPostView(postService: PostService(), user: User(_id: "", username: "", email: "", password: "", avatar: ""))
    }
}
