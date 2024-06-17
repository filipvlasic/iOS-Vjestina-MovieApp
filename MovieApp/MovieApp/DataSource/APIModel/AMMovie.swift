//
//  AMMovie.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import Foundation

struct AMMovie: Decodable {
  let id: Int
  let imageUrl, name, summary: String
  let year: Int
}
