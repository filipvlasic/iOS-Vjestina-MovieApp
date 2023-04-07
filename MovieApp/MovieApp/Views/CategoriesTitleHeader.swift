//
//  CategoriesTitleHeader.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit

class CategoriesTitleHeader: UITableViewHeaderFooterView {
  
  static let identifier = String(describing: CategoriesTitleHeader.self)
  
  private let title = UILabel()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  func addViews() {
    addSubview(title)
  }
  
  func styleViews() {
    title.textColor = .label
    title.font = .systemFont(ofSize: 20, weight: .bold)
  }
  
  func setupConstraints() {
    title.autoPinEdgesToSuperviewEdges(with: .init(top: 0, left: 16, bottom: 0, right: 16))
  }
  
}

extension CategoriesTitleHeader {
  public func update(title: String) {
    self.title.text = title
  }
}
