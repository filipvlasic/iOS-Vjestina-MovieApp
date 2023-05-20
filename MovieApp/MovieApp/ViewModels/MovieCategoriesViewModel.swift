//
//  MovieCategoriesViewModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 19.05.2023..
//

import Foundation

class MovieCategoriesViewModel {
  
  @Published private(set) var freeToWatchMoviesPublished: [MovieCategoriesModel] = .init()
  @Published private(set) var popularMoviesPublished: [MovieCategoriesModel] = .init()
  @Published private(set) var trendingMoviesPublished: [MovieCategoriesModel] = .init()
  
  private let apiClient: APIClient
  
  init(apiClient: APIClient) {
    self.apiClient = apiClient
  }
  
  func fetchFreeToWatchMovies() {
    apiClient.getFreeToWatchMovies { [weak self] amMovie, error in
      if let error { print(error) }
      
      guard let amMovie else { return }
      self?.freeToWatchMoviesPublished = amMovie.map({ MovieCategoriesModel(id: $0.id, imageURL: $0.imageURL, category: "Free To Watch") })
      
    }
  }
  
  func fetchTrendingMovies() {
    apiClient.getTrendingMovies { [weak self] amMovie, error in
      if let error { print(error) }
      
      guard let amMovie else { return }
      self?.trendingMoviesPublished = amMovie.map({ MovieCategoriesModel(id: $0.id, imageURL: $0.imageURL, category: "Trending") })
      
    }
  }
  
  func fetchPopularMovies() {
    apiClient.getPopularMovies { [weak self] amMovie, error in
      if let error { print(error) }
      
      guard let amMovie else { return }
      self?.popularMoviesPublished = amMovie.map({ MovieCategoriesModel(id: $0.id, imageURL: $0.imageURL, category: "What's popular") })
      
    }
  }
  
}
