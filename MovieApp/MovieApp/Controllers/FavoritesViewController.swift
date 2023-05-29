//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 24.04.2023..
//

import UIKit

class FavoritesViewController: UIViewController {
  
  private enum Constants {
    static let cellHeight: CGFloat = 167
    static let cellSpacing: CGFloat = 8
    static let titleColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
    
    static let numberOfItemsInRow: CGFloat = 3
    static let itemSpacing: CGFloat = 8
    static let marginSpacing: CGFloat = 16
  }

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
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsets(
        top: 0,
        left: Constants.marginSpacing,
        bottom: 0,
        right: Constants.marginSpacing)
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdgesToSuperviewSafeArea(with: .init(top: 16, left: 16, bottom: 0, right: 16), excludingEdge: .bottom)
    
    collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 32)
    collectionView.autoPinEdgesToSuperviewSafeArea(with: .init(top: 0, left: 0, bottom: 16, right: 0), excludingEdge: .top)
  }
  
  private func getFavoriteMovies() {
    guard let movies = Preferences.favoriteMoviesIds else { return }
    ids = movies
    fetchData()
    collectionView.reloadData()
  }
  
  private func calculateEntityCellWidth(collectionViewWidth: CGFloat) -> CGFloat {
    let marginesSpace = 2 * Constants.marginSpacing
    let interItemsSpace = (Constants.numberOfItemsInRow - 1) * Constants.itemSpacing
    let emptySpace = marginesSpace + interItemsSpace
    let cellWidth = (collectionViewWidth - emptySpace) / Constants.numberOfItemsInRow
    return cellWidth
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
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: calculateEntityCellWidth(collectionViewWidth: collectionView.bounds.width), height: Constants.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    Constants.itemSpacing // Cell spacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Constants.itemSpacing * 2 // Row spacing
  }
}

extension FavoritesViewController: UICollectionViewDelegate {
  
}
