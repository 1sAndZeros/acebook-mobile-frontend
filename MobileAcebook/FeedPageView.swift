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
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .accessibilityIdentifier("makers-logo")
                    Spacer()
                    NavigationLink {
                        NewPostView(postService: PostService(), user: user)
                    } label: {
                        Text("Post")
                            .frame(width: 60, height: 60)
                            .background(Color("CTA"))
                            .foregroundColor(.white)
                            .clipShape(Circle())
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
            }
        }
    }
}




struct FeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPageView()
    }
}
