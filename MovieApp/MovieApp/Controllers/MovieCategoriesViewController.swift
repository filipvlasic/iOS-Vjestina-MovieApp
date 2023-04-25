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
  
  private let router: Router!
  
  private var categories: [[MovieModel]]!
  private var categorieTitles: [String]!
  
  private var tableView: UITableView!
  
  init(router: Router) {
    self.router = router
    super.init(nibName: nil, bundle: nil)

  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    fetchData()
    setup()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  private func fetchData() {
    let model = MovieUseCase()
    categories = [[MovieModel]]()
    categories.append(model.popularMovies)
    categories.append(model.freeToWatchMovies)
    categories.append(model.trendingMovies)
    
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  private func setup() {
    title = tabBarItem.title

    
    categorieTitles = ["What's popular", "Free to Watch", "Trending"]
    
    tableView = UITableView()
    tableView.register(MovieCategoriesTableViewCell.self, forCellReuseIdentifier: MovieCategoriesTableViewCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
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
    let ids = categories[indexPath.section].map { $0.id }
    let title = categorieTitles[indexPath.section]
    cell.configure(with: categoryURL, categoryTitle: title, ids: ids)
    cell.didTap = { [weak self] (id: Int) in
      self?.router.showMovieDetails(with: id)
    }
      
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
