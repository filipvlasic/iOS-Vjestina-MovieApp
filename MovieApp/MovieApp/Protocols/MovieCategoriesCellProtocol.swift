//
//  MovieCategoriesCellProtocol.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

protocol MovieCategoriesCellProtocol {
  var cellType: UITableViewCell.Type { get }
  var identifier: String { get }
}

extension MovieCategoriesCellProtocol {
  var identifier: String {
    String(describing: cellType)
  }
}
