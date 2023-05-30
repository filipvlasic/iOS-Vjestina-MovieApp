//
//  MovieTagView.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

class MovieTagView: BaseView {
  
  private var movieTags: [MovieTag] = .init()
  
  private let indicator = UIView()
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override func addViews() {
    addSubview(collectionView)
  }
  
  override func styleViews() {
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    collectionView.collectionViewLayout = flowLayout
    collectionView.register(MovieTagCollectionViewCell.self, forCellWithReuseIdentifier: MovieTagCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    
  }
  
  override func setupConstraints() {
    collectionView.autoPinEdgesToSuperviewEdges()
    collectionView.autoSetDimension(.height, toSize: 40)
  }
  
}

extension MovieTagView {
  func update(with movieTags: [MovieTag]) {
    self.movieTags = movieTags
    collectionView.reloadData()
  }
}

extension MovieTagView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    movieTags.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTagCollectionViewCell.identifier, for: indexPath) as? MovieTagCollectionViewCell else { return UICollectionViewCell() }
    
    cell.configure(with: movieTags[indexPath.row].rawValue)
    
    return cell
  }
  
}

extension MovieTagView: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    CGSize(width: 100, height: 30)
//  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    24
  }
}

extension MovieTagView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(movieTags[indexPath.row].rawValue)
  }
}
