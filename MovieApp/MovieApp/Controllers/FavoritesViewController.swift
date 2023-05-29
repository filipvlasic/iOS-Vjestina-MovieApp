//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 24.04.2023..
//

import UIKit

class FavoritesViewController: UIViewController {

  private var router: Router
  private var apiClient: APIClient
  private var ids: [Int] = .init()
  private var moviesURL: [Int: URL?] = .init()
  
  private var titleLabel: UILabel!
  private var collectionView: UICollectionView!
  
  init(router: Router, apiClient: APIClient) {
    self.router = router
    self.apiClient = apiClient
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createViews()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavoriteMovies()
  }
  
  private func fetchData() {
    moviesURL = .init()
    ids.forEach({ id in
      Task.init {
        let res = await apiClient.getMovieDetails(with: id)
        guard let res else { return }
        moviesURL[id] = URL(string: res.imageUrl)
        collectionView.reloadData()
      }
    })
  }
  
  private func createViews() {
    titleLabel = UILabel()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  private func addViews() {
    view.addSubview(titleLabel)
    view.addSubview(collectionView)
  }
  
  private func styleViews() {
    view.backgroundColor = .systemBackground
    
    titleLabel.text = "Favorites"
    
    collectionView.register(MovieCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: MovieCategoriesCollectionViewCell.identifier)
    collectionView.dataSource = self
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdgesToSuperviewSafeArea(with: .init(top: 16, left: 16, bottom: 0, right: 16), excludingEdge: .bottom)
    
    collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 32)
    collectionView.autoPinEdgesToSuperviewSafeArea(with: .init(top: 0, left: 16, bottom: 16, right: 16), excludingEdge: .top)
  }
  
  private func getFavoriteMovies() {
    guard let movies = Preferences.favoriteMoviesIds else { return }
    ids = movies
    fetchData()
    collectionView.reloadData()
  }
  
}

extension FavoritesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    ids.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCategoriesCollectionViewCell.identifier, for: indexPath) as? MovieCategoriesCollectionViewCell else { return UICollectionViewCell() }
    
    let index = indexPath.row
    if index >= ids.count { return cell }
    
    let movieId = ids[indexPath.row]
    let movieURL = moviesURL[movieId]
    guard let movieURL else { return cell }
    
    var image: UIImage?
    if let favoriteIds = Preferences.favoriteMoviesIds {
      if favoriteIds.contains(movieId) {
        image = .heartFill
      } else {
        image = .heart
      }
    }
    guard let image else { return cell }
    cell.configure(with: movieURL, image: image, movieId: movieId) { _ in
      guard let favoriteMovies = Preferences.favoriteMoviesIds else { return }
      var movieIds = Preferences.favoriteMoviesIds!
      if favoriteMovies.contains(movieId) {
        movieIds.removeAll { id in
          id == movieId
        }
        Preferences.favoriteMoviesIds = movieIds
        self.getFavoriteMovies()
      }
    }
    
    
    return cell
  }
  
  
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
  
}
