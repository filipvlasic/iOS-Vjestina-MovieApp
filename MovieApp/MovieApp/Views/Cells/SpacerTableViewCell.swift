//
//  SpacerTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 31.05.2023..
//

import UIKit

class SpacerTableViewCell: UITableViewCell {
  
  let emptyView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(emptyView)
  }
  
  private func setupConstraints() {
    emptyView.autoPinEdgesToSuperviewEdges()
    emptyView.autoSetDimension(.height, toSize: 30)
  }
}
