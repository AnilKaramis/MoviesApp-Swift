//
//  ViewModal.swift
//  CenterMovies
//
//  Created by AnılKaramış on 31.01.2024.
//

import Foundation
import UIKit

struct MainViewModel {
    
    func numberOfSections() -> Int {
        return 1
    }
    func numberOfRows(in section: Int) -> Int {
        return 10
    }
    func getData() {
        APICaller.getTrendingMovies { result in
            switch result {
            case .success(let data):
                print("Top Tredning Counts:\(data.results.count)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

