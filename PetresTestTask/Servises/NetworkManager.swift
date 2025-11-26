//
//  NetworkManager.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    enum Constants {
        static let baseURL = "https://jsonplaceholder.typicode.com"
    }
    
    enum EndPoint {
        static let posts = "/posts"
    }
    
    func getPosts(completion: @escaping(Result<[Posts], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoint.posts)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Posts].self) { response in
                switch response.result {
                case .success(let posts):
                    completion(.success(posts))
                case .failure:
                    completion(.failure(RequestError.errorRequest))
                }
            }
    }
}
