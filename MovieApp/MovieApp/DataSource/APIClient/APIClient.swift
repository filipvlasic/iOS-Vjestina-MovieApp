//
//  APIClient.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import Foundation

protocol APIClient {
  func getFreeToWatchMovies() async -> [MovieModel]?
  func getPopularMovies() async -> [MovieModel]?
  func getTrendingMovies() async -> [MovieModel]?
  func getAllMovies() async -> [MovieModel]?
  func getMovieDetails(with id: Int) async -> AMMovieDetails?
}
