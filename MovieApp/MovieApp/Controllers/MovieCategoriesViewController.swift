//
//  MovieCategoriesViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import MovieAppData

class MovieCategoriesViewController: UIViewController {
  
  private enum Constants {
    static let rowHeight: CGFloat = 179
    static let sectionSpacing: CGFloat = 40
  }
  
  private var categories: [[MovieModel]]!
  private var categorieTitles: [String]!
  
  private var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let model = MovieUseCase()
    categories = [[MovieModel]]()
    categories.append(model.popularMovies)
    categories.append(model.freeToWatchMovies)
    categories.append(model.trendingMovies)
    
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }

//    DispatchQueue.main.async { [weak self] in
//      print("Prvo")
//      self?.tableView.reloadData()
//    }
    
//    DispatchQueue.global().async { [weak self] in
//      let model = MovieUseCase()
//      self?.categories = [[MovieModel]]()
//      self?.categories.append(model.popularMovies)
//      self?.categories.append(model.freeToWatchMovies)
//      self?.categories.append(model.trendingMovies)
//
//      DispatchQueue.main.async { [weak self] in
//        self?.tableView.reloadData()
//      }
//      DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//        self?.tableView.reloadData()
//      }
//    }
    
    
  }
  
  private func setup() {
    categorieTitles = ["What's popular", "Free to Watch", "Trending"]
    
    tableView = UITableView()
    tableView.register(MovieCategoriesTableViewCell.self, forCellReuseIdentifier: MovieCategoriesTableViewCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
//    tableView.rowHeight = UITableView.automaticDimension
  }
  
  private func addViews() {
    view.addSubview(tableView)
  }
  
  private func styleViews() {
    view.backgroundColor = .systemBackground
    
    tableView.separatorStyle = .none
  }
  
  private func setupConstraints() {
    tableView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
    tableView.autoPinEdge(toSuperviewEdge: .bottom)
  }
  
}

extension MovieCategoriesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if let categories {
      return categories.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCategoriesTableViewCell.identifier, for: indexPath) as? MovieCategoriesTableViewCell else { return UITableViewCell() }
    
    let categoryURL = categories[indexPath.section].map { URL(string: $0.imageUrl) } // compactMap
    let title = categorieTitles[indexPath.section]
    cell.configure(with: categoryURL, categoryTitle: title)
      
    return cell
  }
}


extension MovieCategoriesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    UIView()
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    section == (categorieTitles.count - 1) ? 0 : Constants.sectionSpacing
  }

}
