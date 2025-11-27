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
            case .success(let posts):
                self?.posts = posts
                self?.onPostsUpdated?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
