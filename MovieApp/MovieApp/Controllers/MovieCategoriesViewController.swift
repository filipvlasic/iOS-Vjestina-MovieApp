//
//  MovieCategoriesViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import MovieAppData
import Combine

class MovieCategoriesViewController: UIViewController {
  
  private enum Constants {
    static let rowHeight: CGFloat = 179
    static let sectionSpacing: CGFloat = 40
  }
  
  private let router: Router
  
  private var viewModel: MovieCategoriesViewModel!
  private var disposables = Set<AnyCancellable>()
  private var categories: [[MovieCategoriesModel]]!
  
  private var tableView: UITableView!
  
  init(router: Router, viewModel: MovieCategoriesViewModel) {
    self.router = router
    self.viewModel = viewModel
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
    bindData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  private func fetchData() {
    viewModel.fetchFreeToWatchMovies()
    viewModel.fetchPopularMovies()
    viewModel.fetchTrendingMovies()
  }
  
  private func setup() {
    title = tabBarItem.title

    categories = .init()
    
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
  
  private func bindData() {
    
    viewModel
      .$freeToWatchMoviesPublished
      .receive(on: DispatchQueue.main)
      .sink { movies in
        if movies.isEmpty { return }
        self.categories.append(movies)
        self.tableView.reloadData()
      }
      .store(in: &disposables)
    
    viewModel
      .$popularMoviesPublished
      .receive(on: DispatchQueue.main)
      .sink { movies in
        if movies.isEmpty { return }
        self.categories.append(movies)
        self.tableView.reloadData()
      }
      .store(in: &disposables)
    
    viewModel
      .$trendingMoviesPublished
      .receive(on: DispatchQueue.main)
      .sink { movies in
        if movies.isEmpty { return }
        self.categories.append(movies)
        self.tableView.reloadData()
      }
      .store(in: &disposables)
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
  
    let categoryURL = categories[indexPath.section].map { URL(string: $0.imageURL) } // compactMap
    let ids = categories[indexPath.section].map { $0.id }
    let title = categories[indexPath.section][0].category
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
    Constants.sectionSpacing
  }

}
