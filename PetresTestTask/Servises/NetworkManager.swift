//
//  NetworkManager.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import Alamofire
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    enum Constants {
        static let baseURL = "https://jsonplaceholder.typicode.com"
        static let imageURL = "https://picsum.photos/100"
    }
    
    enum EndPoint {
        static let posts = "/posts"
    }
    
    func getPosts(completion: @escaping(Result<[PostResponse], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoint.posts)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [PostResponse].self) { response in
                switch response.result {
                case .success(let posts):
                    completion(.success(posts))
                case .failure:
                    completion(.failure(RequestError.errorRequest))
                }
            }
    }
    
    func getRandomAvatar(completion: @escaping (Result<Data, RequestError>) -> Void) {
        AF.request(Constants.imageURL)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure:
                    completion(.failure(.errorRequest))
                }
            }
    }
}
