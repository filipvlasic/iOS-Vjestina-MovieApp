//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import MovieAppData

class MovieListViewController: UIViewController {
  
  private enum Constants {
    static let itemSpacing: CGFloat = 16
    static let numberOfItemsInRow: CGFloat = 1
    static let cellHeight: CGFloat = 142
    static let rowSpacing: CGFloat = 12
  }
  
  private let allMovies = MovieUseCase().allMovies
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    addViews()
    styleViews()
    setupConstraints()
  }
  
  private func addViews() {
    view.addSubview(collectionView)
  }
  
  private func styleViews() {
    view.backgroundColor = .systemBackground
    
    collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
  }
  
  private func setupConstraints() {
    collectionView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
    collectionView.autoPinEdge(toSuperviewEdge: .bottom)
  }
  
}

extension MovieListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    allMovies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    let url = URL(string: allMovies[indexPath.row].imageUrl)
    let name = allMovies[indexPath.row].name
    let summary = allMovies[indexPath.row].summary
    cell.configure(url: url, name: name, summary: summary)
    return cell
  }
}

extension MovieListViewController: UICollectionViewDelegate {
  
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let interItemSpacing = (Constants.numberOfItemsInRow - 1) * Constants.itemSpacing
    let margins = 2 * Constants.itemSpacing
    let emptySpace = interItemSpacing + margins
    let width = (collectionView.frame.width - emptySpace) / Constants.numberOfItemsInRow
    return CGSize(width: width, height: Constants.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return Constants.rowSpacing
  }
  
}
