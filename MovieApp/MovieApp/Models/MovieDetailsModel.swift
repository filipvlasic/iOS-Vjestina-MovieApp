//
//  MovieDetailsModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 20.05.2023..
//

import Foundation

struct MovieDetailsModel {
  let categories: [String]
  let crewMembers: [CrewMember]
  let id, duration, year: Int
  let rating: Double
  let imageURL, name, releaseDate, summary: String
}

struct CrewMember: Decodable {
  let name, role: String
}
