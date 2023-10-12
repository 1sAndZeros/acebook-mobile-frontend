//
//  FeedPageView.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 11/10/2023.
//

import SwiftUI

struct FeedPageView: View {
    private var service = FeedService()
    @State var posts = [Post]()
    
    var body: some View {
        ZStack {
            AcebookBg()
            VStack {
                HStack {
                    Spacer()
                    Text("Username")
                    Spacer()
                    Image("makers-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .accessibilityIdentifier("makers-logo")
                    //                .padding(.top, 30)
                    Spacer()
                    NavigationLink {
                        NewPostView(postService: PostService())
                    } label: {
                        Text("Post")
                            .frame(width: 60, height: 60)
                            .background(Color("CTA"))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                
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
