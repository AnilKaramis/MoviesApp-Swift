//
//  Service.swift
//  CenterMovies
//
//  Created by AnılKaramış on 31.01.2024.
//

import Foundation
import UIKit
// MARK: - API
struct NetworkConstant {
    static let API_KEY = "https://api.themoviedb.org/3/trending/movie/day?api_key=af067a44d06ee3786eb8c2581fd911ff"
    static let baseURL = "https://api.themoviedb.org"
}

// MARK: - Enums
enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    
    static func getTrendingMovies(completion: @escaping (Result<TrendingMoviesModel, Error>) -> Void) {
        
        let task  = URLSession.shared.dataTask(with: URLRequest(url: getFullURL())) {
            data, response, error in
            guard let data = data, error == nil else {
                print(String(describing: error))
                print("1111111111")
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMoviesModel.self , from: data)
                print(results)
                print("0000000000000000")
                completion(.success(results))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func getFullURL() -> URL {
        guard let url = URL(string: "\(NetworkConstant.API_KEY)") else {
            return URL(string: NetworkConstant.baseURL)!}
        return url
        }
    
}

