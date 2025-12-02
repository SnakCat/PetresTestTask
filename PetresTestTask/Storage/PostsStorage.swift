//
//  PostsStorage.swift
//  PetresTestTask
//
//  Created by DimaTru on 02.12.2025.
//

import CoreData

final class PostsStorage {
    
    private let context = CoreDataManager.shared.context
    
    func savePosts(_ posts: [Posts]) {
        let fetch: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        try? context.execute(deleteRequest)
        
        for post in posts {
            let entity = PostEntity(context: context)
            entity.id = Int64(post.id)
            entity.title = post.title
            entity.body = post.body
            entity.avatar = post.avatar
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    func fetchPosts() -> [Posts] {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        guard let result = try? context.fetch(request) else { return [] }
        return result.map {
            Posts(id: Int($0.id),
                  title: $0.title ?? "",
                  body: $0.body ?? "",
                  avatar: $0.avatar ?? Data())
        }
    }
}
