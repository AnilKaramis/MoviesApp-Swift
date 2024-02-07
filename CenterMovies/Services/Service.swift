//
//  Service.swift
//  CenterMovies
//
//  Created by AnılKaramış on 31.01.2024.
//

import Foundation
import UIKit

//MARK: -RXSWIFT SERVICE

enum MoviesError: Error
{
    case serverError
    case parsingError
}

class Webservice {
    
    func download(url: URL , completion: @escaping (Result<Movies, MoviesError>) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
            } else if let ServiceData = data {
                let MoviesListData = try? JSONDecoder().decode(Movies.self, from: ServiceData)
                if let SuccessMoviesListData = MoviesListData {
                    completion(.success(SuccessMoviesListData))
                } else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}



