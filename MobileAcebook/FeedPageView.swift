//
//  FeedPageView.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 11/10/2023.
//

import SwiftUI

struct FeedPageView: View {
    private var service = FeedService()
    private var userService = UserService()
    @State var posts = [Post]()
    @State var user: User = User(_id: "", username: "", email: "", password: "", avatar: "")
    @State private var goToHome: Bool = false
    
    func logout() {
        // Remove the token from UserDefaults or wherever it is stored
        UserDefaults.standard.removeObject(forKey: "token")
        
        // Reset the email and password fields
//        user.email = ""
//        user.password = ""
        goToHome = true
    }
 
    var body: some View {
        ZStack {
            AcebookBg()
            VStack {
                HStack {

                    AsyncImage(url: URL(string: user.avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
//                    Text(user.username)
                        .onAppear {
                            guard var token = UserDefaults.standard.string(forKey: "token") else {
                                return
                            }
                            userService.getUser(token: token) { (users, err) in
                                guard var users = users else {
                                    // handle error
                                    return
                                }
                                self.user = users.user
                            }
                        }
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .accessibilityIdentifier("logo")
                    Spacer()
                    Button(action: {
                        logout()
                    }, label: {
                        Image(systemName: "person.crop.circle.badge.xmark")
                    })
                    .frame(width: 60, height: 60)
                    .background(Color("AccentColor"))
                    .foregroundColor(Color("Primary"))
                    .clipShape(Circle())
                    
                    NavigationLink(
                        destination: WelcomePageView()
                            .navigationBarTitle("")
                            .navigationBarHidden(true),
                        isActive: $goToHome)
                    {
                        EmptyView()
                    }
                    
                }.frame(width: 350)
                
                VStack {
                ForEach(posts, id: \._id) { post in
                        Text(post.message)
                        .frame(width: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                    }
                }
                .onAppear {
                    guard var token = UserDefaults.standard.string(forKey: "token") else {
                        return
                    }
                    service.loadPosts(token: token) { (posts, err) in
                        guard var posts = posts else {
                            // handle error
                            return
                        }
                        self.posts = posts.posts
                    }
                }
                Spacer()
                NavigationLink {
                    NewPostView(postService: PostService(), user: user)
                } label: {
                    Image(systemName: "square.and.pencil")
                        .frame(width: 70, height: 70)
                        .imageScale(.large)
                        .background(Color("CTA"))
                        .foregroundColor(Color("Primary"))
                        .clipShape(Circle())
                }
            }
        }
    }
}




struct FeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPageView()
    }
}
