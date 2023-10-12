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
        
        HStack {
            Text("Username")
            Spacer()
            Image("makers-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .accessibilityIdentifier("makers-logo")
            //                .padding(.top, 30)
            Spacer()
            Button(action: {
                // add line to new post
            },label: {
                Text("Post")
                    .foregroundColor(Color.white)
                    .font(.headline)
            }
            ).padding(.vertical, 15)
                .padding(.horizontal, 30)
                .background(Color("CTA"))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
        List(posts, id: \._id) { post in
            Text(post.message)
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
    }
}



struct FeedPageView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPageView()
    }
}
