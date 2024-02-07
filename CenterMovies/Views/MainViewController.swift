//
//  MainViewController.swift
//  CenterMovies
//
//  Created by AnılKaramış on 31.01.2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    // MARK: - Variables
    
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    var ListModel = [Movies]()
    
    var movieTable:UITableView = {
        var table = UITableView()
        return table
    }()
    let indicatorView : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        return indicator
    }()
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(movieTable)
        view.addSubview(indicatorView)
        
        setupTableView()
        MakeConstraint()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupBindings()
        viewModel.getData()
    }
    private func setupBindings() {
        // Loading
        viewModel.loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        //Error
        viewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        //Model
        viewModel
            .Movies
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { subMovies in
                self.ListModel = subMovies
                self.movieTable.reloadData()
            }.disposed(by: disposeBag)
    }
    func setupTableView() {
        self.title = "Main View"
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        registerCells()
    }
}
// MARK: - Extensions

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func registerCells() {
        movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
