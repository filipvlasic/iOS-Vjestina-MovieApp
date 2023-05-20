//
//  AMMovieDetails.swift
//  MovieApp
//
//  Created by Filip Vlašić on 20.05.2023..
//

import Foundation

struct AMMovieDetails: Decodable {
  let categories: [String]
  let crewMembers: [AMCrewMember]
  let id, duration, year: Int
  let rating: Double
  let imageURL, name, releaseDate, summary: String
}

struct AMCrewMember: Decodable {
  let name, role: String
}
