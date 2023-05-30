//
//  CategoryTableViewCellModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

struct CategoryTableViewCellModel: MovieCategoriesCellProtocol {
  var cellType: UITableViewCell.Type = CategoryTableViewCell.self
  let title: String
}
