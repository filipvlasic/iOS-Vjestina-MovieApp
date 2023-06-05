//
//  MovieModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import Foundation

struct MovieModel {
  let id: Int
  let imageUrl, name, summary: String
  let year: Int
  let category: MovieCategory
  let movieTag: MovieTag
}

enum MovieCategory: String {
  case trending = "trending"
  case popular = "popular"
  case freeToWatch = "free-to-watch"
}
