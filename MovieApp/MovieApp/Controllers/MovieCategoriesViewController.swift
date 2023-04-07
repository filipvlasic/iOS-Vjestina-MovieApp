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
  }
  
  private var categories = [[MovieModel]]()
  private let categorieTitles = ["What's popular", "Free to Watch", "Trending"]
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  private func setup() {
    let model = MovieUseCase()
    categories.append(model.popularMovies)
    categories.append(model.freeToWatchMovies)
    categories.append(model.trendingMovies)
  }
  
  private func addViews() {
    view.addSubview(tableView)
  }
  
  private func styleViews() {
    tableView.register(MovieCategoriesTableViewCell.self, forCellReuseIdentifier: MovieCategoriesTableViewCell.identifier)
    tableView.dataSource = self
    tableView.register(CategoriesTitleHeader.self, forHeaderFooterViewReuseIdentifier: CategoriesTitleHeader.identifier)
    tableView.delegate = self
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
    return categorieTitles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCategoriesTableViewCell.identifier, for: indexPath) as? MovieCategoriesTableViewCell else { return UITableViewCell() }
    
    let categoryURL = categories[indexPath.section].map { movieModel in
      URL(string: movieModel.imageUrl)
    }
    cell.configure(with: categoryURL)
    return cell
  }
}

extension MovieCategoriesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoriesTitleHeader.identifier) as? CategoriesTitleHeader else { return nil}
    header.contentView.layoutMargins = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 0)
    header.update(title: categorieTitles[section])
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    Constants.rowHeight
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    44
  }
}
