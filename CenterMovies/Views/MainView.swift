//
//  MainView.swift
//  CenterMovies
//
//  Created by AnılKaramış on 1.02.2024.
//

import Foundation
import SnapKit

extension MainViewController {

    func MakeConstraint() {
        movieTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
