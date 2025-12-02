//
//  PostViewModel.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import Foundation

//MARK: - протокол для ViewModel
protocol PostViewModelProtocol {
    var posts: [Posts] { get }
    var onPostsUpdated: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func fetchPosts()
}

final class PostViewModel: PostViewModelProtocol {
    
    //MARK: - свойства
    private(set) var posts: [Posts] = []
    private let storage = PostsStorage()

    var onPostsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    //MARK: - метод запроса постов по API
    func fetchPosts() {
        let saved = storage.fetchPosts()
        if !saved.isEmpty {
            onPostsUpdated?()
        }
        NetworkManager.shared.getPosts { [weak self] result in
            switch result {
            case .success(let postResponses):
                self?.mapPostsWithAvatars(postResponses)

            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    //MARK: - метод добавления аватарки к посту через GCD 
    private func mapPostsWithAvatars(_ posts: [PostResponse]) {
        var fullPosts: [Posts] = []
        let group = DispatchGroup()
        
        for post in posts {
            group.enter()
            
            NetworkManager.shared.getRandomAvatar { result in
                switch result {
                case .success(let data):
                    fullPosts.append(
                        Posts(id: post.id,
                              title: post.title,
                              body: post.body,
                              avatar: data)
                    )
                case .failure:
                    fullPosts.append(
                        Posts(id: post.id,
                              title: post.title,
                              body: post.body,
                              avatar: Data())
                    )
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.posts = fullPosts
            self?.storage.savePosts(fullPosts)
            self?.onPostsUpdated?()
        }
    }
}
