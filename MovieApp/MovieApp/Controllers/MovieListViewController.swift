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
  
  private var allMovies: [MovieModel]! // init
  
  private var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    allMovies = MovieUseCase().allMovies
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
  private func setupViews() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func addViews() {
    view.addSubview(collectionView)
  }
  
  private func styleViews() {
    view.backgroundColor = .systemBackground
    
    collectionView.backgroundColor = .systemBackground
  }
  
  private func setupConstraints() {
    collectionView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
    collectionView.autoPinEdge(toSuperviewEdge: .bottom)
  }
  
}

extension MovieListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let allMovies {
      return allMovies.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    let index = indexPath.row
    let url = URL(string: allMovies[index].imageUrl)
    let name = allMovies[index].name
    let summary = allMovies[index].summary
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
    Constants.rowSpacing
  }
  
}
