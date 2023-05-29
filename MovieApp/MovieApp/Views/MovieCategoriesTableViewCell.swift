//
//  MovieCategoriesTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import MovieAppData

class MovieCategoriesTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let cellHeight: CGFloat = 179
    static let cellWidth: CGFloat = 122
    static let cellSpacing: CGFloat = 8
    static let titleColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
  }
  
  var didTap: ((Int) -> Void)?
  
  static let identifier = String(describing: MovieCategoriesTableViewCell.self)
  private var moviesURL: [URL?]!
  private var ids: [Int]!
  
  private var titleLabel: UILabel!
  private var collectionView: UICollectionView!

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func setup() {
    titleLabel = UILabel()
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(MovieCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: MovieCategoriesCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func addViews() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(collectionView)
  }
  
  private func styleViews() {
    titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    titleLabel.textColor = Constants.titleColor
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewEdge: .top)
    
    collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 16)
    collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), excludingEdge: .top)
    collectionView.autoSetDimension(.height, toSize: Constants.cellHeight)
  }
  
  override func prepareForReuse() {
    titleLabel.text = ""
    collectionView.reloadData()
  }
}

extension MovieCategoriesTableViewCell {
  public func configure(with moviesURL: [URL?], categoryTitle: String, ids: [Int]) {
    self.moviesURL = moviesURL
    self.titleLabel.text = categoryTitle
    self.ids = ids
    self.collectionView.reloadData()
  }
}

extension MovieCategoriesTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let moviesURL {
      return moviesURL.count
    } else {
      return 0
    }
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCategoriesCollectionViewCell.identifier, for: indexPath) as? MovieCategoriesCollectionViewCell else { return UICollectionViewCell() }
    
    let movieURL = moviesURL[indexPath.row]
    let movieId = ids[indexPath.row]
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
      } else {
        movieIds.append(movieId)
        Preferences.favoriteMoviesIds = movieIds
      }
      collectionView.reloadData()
    }
    
    
    return cell
  }
}

extension MovieCategoriesTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let id = ids[indexPath.row]
    didTap?(id)
  }
}


extension MovieCategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Constants.cellSpacing
  }
  
}
