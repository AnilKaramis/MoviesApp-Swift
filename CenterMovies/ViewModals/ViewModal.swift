//
//  ViewModal.swift
//  CenterMovies
//
//  Created by AnılKaramış on 31.01.2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct MainViewModel {
    
    let Movies: PublishSubject<[Movies]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func numberOfSections() -> Int {
        return 1
    }
    func numberOfRows(in section: Int) -> Int {
        return 10
    }
    func getData() {
        self.loading.onNext(true)
        let APIkey = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=af067a44d06ee3786eb8c2581fd911ff")!
        Webservice().download(url: APIkey) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let success):
                self.Movies.onNext([success])
            case .failure(let error):
                switch error {
                case .serverError:
                    self.error.onNext("Server Error")
                case .parsingError:
                    self.error.onNext("Parsing Error")
                }
            }
        }
    }
}

