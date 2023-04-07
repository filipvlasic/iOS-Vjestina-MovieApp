//
//  MovieCategoriesCollectionViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit

class MovieCategoriesCollectionViewCell: UICollectionViewCell {
  
  private enum Constants {
    static let heartBackgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 0.3)
  }
  
  static let identifier = String(describing: MovieCategoriesCollectionViewCell.self)
  
  private let imageView = UIImageView()
  private let heart = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(imageView)
    contentView.addSubview(heart)
  }
  
  private func styleViews() {    
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    
    heart.setImage(UIImage(systemName: "heart"), for: .normal)
    heart.tintColor = .white
    heart.backgroundColor = Constants.heartBackgroundColor
    heart.layer.cornerRadius = 16
  }
  
  private func setupConstraints() {
    imageView.autoPinEdgesToSuperviewEdges()
    
    heart.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
    heart.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
    heart.autoSetDimensions(to: CGSize(width: 32, height: 32))
  }
  
}

extension MovieCategoriesCollectionViewCell {
  public func configure(with url: URL?) {
    self.imageView.kf.setImage(with: url)
  }
}
