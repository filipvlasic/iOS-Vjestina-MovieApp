//
//  MovieListCollectionViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
  
  private enum Constants {
    static let summaryTextColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
  }
  
  static let identifier = String(describing: MovieListCollectionViewCell.self)
  
  private let imageView = UIImageView()
  private let name = UILabel()
  private let summary = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(imageView)
    contentView.addSubview(name)
    contentView.addSubview(summary)
  }
  
  private func styleViews() {
    backgroundColor = .systemBackground
    layer.masksToBounds = false
    layer.cornerRadius = 10
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.1
    layer.shadowOffset = CGSize(width: 4, height: 8)
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 10
    imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    imageView.clipsToBounds = true
    
    name.textColor = .label
    name.font = .systemFont(ofSize: 16, weight: .bold)
    name.numberOfLines = 0
    name.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    
    summary.textColor = Constants.summaryTextColor
    summary.font = .systemFont(ofSize: 14)
    summary.numberOfLines = 0
    summary.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
  }
  
  private func setupConstraints() {
    imageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .trailing)
    imageView.autoSetDimension(.width, toSize: 97)
    
    name.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 16)
    name.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
    name.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12, relation: .greaterThanOrEqual)
    
    summary.autoPinEdge(.top, to: .bottom, of: name, withOffset: 8)
    summary.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 16)
    summary.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
    summary.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12, relation: .greaterThanOrEqual)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    name.text = ""
    summary.text = ""
  }
}

extension MovieListCollectionViewCell {
  public func configure(url: URL?, name: String?, summary: String?) {
    guard let url, let name, let summary else { return }
    self.imageView.kf.setImage(with: url)
    self.name.text = name
    self.summary.text = summary
  }
}
