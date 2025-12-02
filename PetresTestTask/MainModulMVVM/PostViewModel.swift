//
//  PostViewModel.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import Foundation

protocol PostViewModelProtocol {
    var posts: [Posts] { get }
    var onPostsUpdated: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func fetchPosts()
}

final class PostViewModel: PostViewModelProtocol {
    
    private(set) var posts: [Posts] = []

    var onPostsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchPosts() {
        NetworkManager.shared.getPosts { [weak self] result in
            switch result {
            case .success(let postResponses):
                self?.mapPostsWithAvatars(postResponses)

            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }

    private func mapPostsWithAvatars(_ posts: [PostResponse]) {
        var fullPosts: [Posts] = []
        let group = DispatchGroup()
        
        for post in posts {
            group.enter()
            
            NetworkManager.shared.getRandomAvatar { result in
                switch result {
                case .success(let data):
                    fullPosts.append(
                        Posts(id: post.id, title: post.title, body: post.body, avatar: data)
                    )
                case .failure:
                    fullPosts.append(
                        Posts(id: post.id, title: post.title, body: post.body, avatar: Data())
                    )
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.posts = fullPosts
            self?.onPostsUpdated?()
        }
    }
}
