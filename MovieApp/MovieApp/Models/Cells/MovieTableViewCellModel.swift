//
//  MovieTableViewCellModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

struct MovieTableViewCellModel: MovieCategoriesCellProtocol {
  var cellType: UITableViewCell.Type = MovieTableViewCell.self
  let movies: [MovieCategoriesModel]
  let didTap: ((Int) -> Void)?
}
