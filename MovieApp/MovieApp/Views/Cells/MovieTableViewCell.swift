//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    
  }
  
  private func styleViews() {
    
  }
  
  private func setupConstraints() {
    
  }
  
}

extension MovieTableViewCell: Configurable {
  func configure(with model: Any) {
    guard let model = model as? MovieTableViewCellModel else { return }
  }
}
