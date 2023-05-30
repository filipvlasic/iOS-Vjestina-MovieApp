//
//  MovieCategoriesCollectionViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import Kingfisher

class MovieCategoriesCollectionViewCell: UICollectionViewCell {
  
  private enum Constants {
    static let heartBackgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 0.3)
  }
  
  private var didTapHeart: (() -> Void)?
  
  static let identifier = String(describing: MovieCategoriesCollectionViewCell.self)
  
  private var imageView: UIImageView!
  private var heart: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
    addViews()
    styleViews()
    setupConstraints()
    setupActions()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func setup() {
    imageView = UIImageView()
    heart = UIButton()
  }
  
  private func addViews() {
    contentView.addSubview(imageView)
    contentView.addSubview(heart)
  }
  
  private func styleViews() {    
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    
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
  
  private func setupActions() {
    heart.addTarget(self, action: #selector(tap), for: .touchUpInside)
  }
  
  @objc
  private func tap() {
    didTapHeart?()
  }
  
  override func prepareForReuse() {
    imageView.image = nil
  }
  
}

extension MovieCategoriesCollectionViewCell {
  @discardableResult
  public func configure(with url: URL?, image: UIImage, didTapHeart: @escaping () -> Void) -> Self {
    imageView.kf.setImage(with: url)
    heart.setImage(image, for: .normal)
    self.didTapHeart = didTapHeart
    return self
  }
}
