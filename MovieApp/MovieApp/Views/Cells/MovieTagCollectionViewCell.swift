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
    titleLabel.font = .systemFont(ofSize: 16)
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdgesToSuperviewEdges()
  }
  
  override func prepareForReuse() {
    titleLabel.text = ""
  }
  
}

extension MovieTagCollectionViewCell {
  func configure(with title: String, color: UIColor) {
    titleLabel.text = title
    titleLabel.textColor = color
  }
}
