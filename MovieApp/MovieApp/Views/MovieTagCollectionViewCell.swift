//
//  MovieTagCollectionViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

class MovieTagCollectionViewCell: UICollectionViewCell {
  
  static let identifier: String = String(describing: MovieCategoriesCollectionViewCell.self)
  
  private let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(titleLabel)
  }
  
  private func styleViews() {
    titleLabel.textColor = .black
    titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdgesToSuperviewEdges()
  }
  
}

extension MovieTagCollectionViewCell {
  func configure(with title: String) {
    titleLabel.text = title
  }
}
