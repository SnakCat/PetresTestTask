//
//  PostModel.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import Foundation

    //MARK: - модель для поста без аватарки
struct PostResponse: Decodable {
    let id: Int
    let title: String
    let body: String
}

    //MARK: - модель поста для UI с аватаркой
struct Posts {
    let id: Int
    let title: String
    let body: String
    let avatar: Data
}
