//
//  NativeAPIClient.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import UIKit
import MovieAppData

enum MovieTag: String, Decodable {
    case streaming = "STREAMING"
    case onTv = "ON_TV"
    case forRent = "FOR_RENT"
    case inTheaters = "IN_THEATERS"
    case movie = "MOVIE"
    case tvShow = "TV_SHOW"
    case trendingToday = "TODAY"
    case trendingThisWeek = "THIS_WEEK"
}

struct NativeAPIClient: APIClient {
  
  private enum Constants {
    static let baseURL = "https://five-ios-api.herokuapp.com"
    static let key = "Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps"
  }
  
  let session = URLSession.shared
  let decoder = JSONDecoder()
  
  func getFreeToWatchMovies() async -> [AMMovie]? {
    var movies = [AMMovie]()
    async let a = makeMovieCall(path: "free-to-watch", category: MovieTag.movie.rawValue)
    async let b = makeMovieCall(path: "free-to-watch", category: MovieTag.tvShow.rawValue)
    
    let c = await [a, b]
    c.forEach { movies.append(contentsOf: $0) }
    return movies
  }
  
  func getPopularMovies() async -> [AMMovie]? {
    var movies = [AMMovie]()
    async let a = makeMovieCall(path: "popular", category: MovieTag.forRent.rawValue)
    async let b = makeMovieCall(path: "popular", category: MovieTag.inTheaters.rawValue)
    async let c = makeMovieCall(path: "popular", category: MovieTag.onTv.rawValue)
    async let d = makeMovieCall(path: "popular", category: MovieTag.streaming.rawValue)

    let f = await [a, b, c, d]
    f.forEach { movies.append(contentsOf: $0) }
    return movies
  }
  
  func getTrendingMovies() async -> [AMMovie]? {
    var movies = [AMMovie]()
    async let a = makeMovieCall(path: "trending", category: MovieTag.trendingThisWeek.rawValue)
    async let b = makeMovieCall(path: "trending", category: MovieTag.trendingToday.rawValue)

    let c = await [a, b]
    c.forEach { movies.append(contentsOf: $0) }
    return movies
  }
  
  func getAllMovies() async -> [AMMovie]? {
    var movies = [AMMovie]()
    async let a = getTrendingMovies()
    async let b = getPopularMovies()
    async let c = getFreeToWatchMovies()

    let d = await [a, b, c]
    d.forEach { movies.append(contentsOf: $0!) }
    return movies
  }
  
  func getMovieDetails(with id: Int) async -> AMMovieDetails? {
    async let a = makeMovieDetailsCall(id: id)
    
    let c = await a
    return c
  }
  
  private func makeMovieCall(path: String, category: String) async -> [AMMovie] {
    var movies = [AMMovie]()
    guard let url = URL(string: "\(Constants.baseURL)/api/v1/movie/\(path)?criteria=\(category)") else { return []}
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("Bearer \(Constants.key)", forHTTPHeaderField: "Authorization")
    
    var data: Data?
    do {
      (data, _) = try await session.data(for: urlRequest)
    } catch (let error) {
      print(error)
    }
    do {
      guard let data else { return [] }
      let res = try decoder.decode([AMMovie].self, from: data)
      movies.append(contentsOf: res)
    } catch (let error) {
      print(error)
    }
    
    return movies
  }
  
  private func makeMovieDetailsCall(id: Int) async -> AMMovieDetails? {
    guard let url = URL(string: "\(Constants.baseURL)/api/v1/movie/\(id)/details") else { return nil}
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("Bearer \(Constants.key)", forHTTPHeaderField: "Authorization")
    
    var data: Data?
    do {
      (data, _) = try await session.data(for: urlRequest)
    } catch (let error) {
      print(error)
    }
    do {
      guard let data else { return nil }
      let res = try decoder.decode(AMMovieDetails.self, from: data)
      return res
    } catch (let error) {
      print(error)
    }
    
    return nil
  }
  
}
