//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let cellHeight: CGFloat = 179
    static let cellWidth: CGFloat = 122
    static let cellSpacing: CGFloat = 8
    static let titleColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
  }
  
  private var didTap: ((Int) -> Void)?
  private var model: [MovieCategoriesModel] = .init()
  
  private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(collectionView)
  }
  
  private func styleViews() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    collectionView.collectionViewLayout = flowLayout
    collectionView.register(MovieCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: MovieCategoriesCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setupConstraints() {
    collectionView.autoPinEdge(toSuperviewEdge: .top)
    collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), excludingEdge: .top)
    collectionView.autoSetDimension(.height, toSize: Constants.cellHeight)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    collectionView.reloadData()
  }
  
  private func calculateImage(for movieId: Int) -> UIImage {
    if let favoriteIds = Preferences.favoriteMoviesIds {
      if favoriteIds.contains(movieId) {
        return .heartFill
      } else {
        return .heart
      }
    }
    return .heart
  }
  
}

extension MovieTableViewCell: Configurable {
  func configure(with model: Any) {
    guard let model = model as? MovieTableViewCellModel else { return }
    self.model = model.movies
    self.didTap = model.didTap
  }
}

extension MovieTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    model.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCategoriesCollectionViewCell.identifier, for: indexPath) as? MovieCategoriesCollectionViewCell else { return UICollectionViewCell() }
    
    let currentModel = model[indexPath.row]
    let movieURL = URL(string: currentModel.imageURL)
    let movieId = currentModel.id
    let image = calculateImage(for: movieId)
    
    cell.configure(with: movieURL, image: image) {
      guard let favoriteMovies = Preferences.favoriteMoviesIds else { return }
      var movieIds = Preferences.favoriteMoviesIds!
      if favoriteMovies.contains(movieId) {
        movieIds.removeAll { id in
          id == movieId
        }
        Preferences.favoriteMoviesIds = movieIds
      } else {
        movieIds.append(movieId)
        Preferences.favoriteMoviesIds = movieIds
      }
      collectionView.reloadData()
    }
    
    
    return cell
  }
  
}

extension MovieTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    didTap?(model[indexPath.row].id)
  }
}


extension MovieTableViewCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Constants.cellSpacing
  }
  
}
