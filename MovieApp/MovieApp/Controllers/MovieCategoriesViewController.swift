//
//  MovieCategoriesViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import Combine
import PureLayout

class MovieCategoriesViewController: UIViewController {
  
  private enum Constants {
    static let rowHeight: CGFloat = 179
    static let sectionSpacing: CGFloat = 40
  }
  
  private let router: Router
  
  private var viewModel: MovieCategoriesViewModel!
  private var disposables = Set<AnyCancellable>()
  private var model: [MovieCategoriesCellProtocol] = .init()
  
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
    viewModel.fetchAllMovies()
  }
  
  private func setup() {
    title = tabBarItem.title
    
    tableView = UITableView()
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
      .$allMoviesPublished
      .receive(on: DispatchQueue.main)
      .sink { movies in
        if movies.isEmpty { return }
        self.populateModel(from: movies)
        self.registerCells()
        self.tableView.reloadData()
      }
      .store(in: &disposables)
  }
  
  // TODO: u helper
  private func convertToTitle(_ category: MovieCategory) -> String {
    switch category {
    case .freeToWatch:
      return "Free To Watch"
    case .popular:
      return "What's Popular"
    case .trending:
      return "Trending"
    }
  }
  
  private func populateModel(from movieCategoriesModel: [MovieCategoriesModel]) {
    let categoryTitles: [MovieCategory] = [.popular, .freeToWatch, .trending]
    categoryTitles.forEach { category in
      model.append(CategoryTableViewCellModel(title: convertToTitle(category)))
      
      var movieTags: Set<MovieTag> = .init()
      movieCategoriesModel
        .filter { category == $0.category }
        .forEach { movieTags.insert($0.movieTag) }
      let tagsSorted = Array(movieTags).sorted(by: { $0.rawValue < $1.rawValue })
      model.append(MovieTagTableViewCellModel(movieTags: tagsSorted))
      
      let movies = movieCategoriesModel
        .filter { category == $0.category }
        .compactMap {
          MovieCategoriesModel(id: $0.id, imageURL: $0.imageURL, category: $0.category, movieTag: $0.movieTag)
        }
      model.append(MovieTableViewCellModel(movies: movies))
    }
  }
  
  private func registerCells() {
    model.forEach { tableView.register($0.cellType, forCellReuseIdentifier: $0.identifier) }
  }
  
}

extension MovieCategoriesViewController: UITableViewDataSource {
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    model.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let currentModel = model[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: currentModel.identifier, for: indexPath)

    if let configure = cell as? Configurable {
      configure.configure(with: currentModel)
    }
    
    return cell
  }
}


extension MovieCategoriesViewController: UITableViewDelegate {

}
