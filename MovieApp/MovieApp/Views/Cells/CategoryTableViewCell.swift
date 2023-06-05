//
//  CategoryTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let titleColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
  }
  
  private let titleLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(titleLabel)
  }
  
  private func styleViews() {
    titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    titleLabel.textColor = Constants.titleColor
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewEdge: .top)
    titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
  }

}

extension CategoryTableViewCell: Configurable {
  func configure(with model: Any) {
    guard let model = model as? CategoryTableViewCellModel else { return }
    titleLabel.text = model.title
  }
}
