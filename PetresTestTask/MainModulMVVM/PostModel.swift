//
//  PostModel.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import Foundation

struct PostResponse: Decodable {
    let id: Int
    let title: String
    let body: String
}

struct Posts {
    let id: Int
    let title: String
    let body: String
    let avatar: Data
}
