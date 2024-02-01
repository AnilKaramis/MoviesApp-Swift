//
//  Model.swift
//  CenterMovies
//
//  Created by AnılKaramış on 31.01.2024.
//

import Foundation
import UIKit

struct TrendingMoviesModel: Codable {
    let page: Int
    let results: [Movies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movies: Codable, Hashable {
    let id: Int
    let type: Int
    let series: Bool
    let name: String
    let time: Int
    let genre: [String]
    let rating: String
    let votes: String
    let photo: String
    let miniPhoto: String
    let description: String
    let trailer: String
    let comments: [Comments]
}
struct Comments: Codable, Hashable {
    let id: Int?
    let name: String?
    let comment: String?
    let picture: String?
}

