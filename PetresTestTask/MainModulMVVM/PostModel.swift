//
//  PostModel.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

struct Posts: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
