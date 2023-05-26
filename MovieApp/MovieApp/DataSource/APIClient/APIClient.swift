//
//  APIClient.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import Foundation

protocol APIClient {
  func getFreeToWatchMovies() async -> [AMMovie]?
  func getPopularMovies() async -> [AMMovie]?
  func getTrendingMovies() async -> [AMMovie]?
  func getAllMovies() async -> [AMMovie]?
  func getMovieDetails(with id: Int) async -> AMMovieDetails?
}
