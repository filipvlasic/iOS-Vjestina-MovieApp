//
//  APIClient.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import Foundation

protocol APIClient {
  func getFreeToWatchMovies(completion: @escaping ([AMMovie]?, Error?) -> Void)
  func getPopularMovies(completion: @escaping ([AMMovie]?, Error?) -> Void)
  func getTrendingMovies(completion: @escaping ([AMMovie]?, Error?) -> Void)
  func getAllMovies(completion: @escaping ([AMMovie]?, Error?) -> Void)
  func getMovieDetails(with id: Int, completion: @escaping (AMMovieDetails?, Error?) -> Void)
}
