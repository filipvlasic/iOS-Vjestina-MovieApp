//
//  NativeAPIClient.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import UIKit

enum MovieTag: String {
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
  
  func getFreeToWatchMovies() async -> [MovieModel]? {
    var movies = [MovieModel]()
    async let a = makeMovieCall(movieCategory: MovieCategory.freeToWatch, movieTag: MovieTag.movie)
    async let b = makeMovieCall(movieCategory: MovieCategory.freeToWatch, movieTag: MovieTag.tvShow)
    
    let c = await [a, b]
    c.forEach {
      movies.append(contentsOf: $0)
    }
    return movies
  }
  
  func getPopularMovies() async -> [MovieModel]? {
    var movies = [MovieModel]()
    async let a = makeMovieCall(movieCategory: MovieCategory.popular, movieTag: MovieTag.forRent)
    async let b = makeMovieCall(movieCategory: MovieCategory.popular, movieTag: MovieTag.inTheaters)
    async let c = makeMovieCall(movieCategory: MovieCategory.popular, movieTag: MovieTag.onTv)
    async let d = makeMovieCall(movieCategory: MovieCategory.popular, movieTag: MovieTag.streaming)

    let f = await [a, b, c, d]
    f.forEach { movies.append(contentsOf: $0) }
    return movies
  }
  
  func getTrendingMovies() async -> [MovieModel]? {
    var movies = [MovieModel]()
    async let a = makeMovieCall(movieCategory: MovieCategory.trending, movieTag: MovieTag.trendingThisWeek)
    async let b = makeMovieCall(movieCategory: MovieCategory.trending, movieTag: MovieTag.trendingToday)

    let c = await [a, b]
    c.forEach { movies.append(contentsOf: $0) }
    return movies
  }
  
  func getAllMovies() async -> [MovieModel]? {
    var movies = [MovieModel]()
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
  
  private func makeMovieCall(movieCategory: MovieCategory, movieTag: MovieTag) async -> [MovieModel] {
    var movies = [AMMovie]()
    guard let url = URL(string: "\(Constants.baseURL)/api/v1/movie/\(movieCategory.rawValue)?criteria=\(movieTag.rawValue)") else { return []}
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
    let movieModels = movies.compactMap { amMovie in
      MovieModel(id: amMovie.id, imageUrl: amMovie.imageUrl, name: amMovie.name, summary: amMovie.summary, year: amMovie.year, category: movieCategory, movieTag: movieTag)
    }
    return movieModels
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
