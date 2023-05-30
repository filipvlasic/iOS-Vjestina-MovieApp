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
    Task.init {
      let res = await apiClient.getFreeToWatchMovies()
      guard let res else { return }
      freeToWatchMoviesPublished = res.map({ MovieCategoriesModel(
        id: $0.id,
        imageURL: $0.imageUrl,
        category: $0.category,
        movieTag: $0.movieTag) })
    }
  }
  
  func fetchTrendingMovies() {
    Task.init {
      let res = await apiClient.getTrendingMovies()
      guard let res else { return }
      trendingMoviesPublished = res.map({ MovieCategoriesModel(id: $0.id,
                                                               imageURL: $0.imageUrl,
                                                               category: $0.category,
                                                               movieTag: $0.movieTag) })
    }
  }
  
  func fetchPopularMovies() {
    Task.init {
      let res = await apiClient.getPopularMovies()
      guard let res else { return }
      trendingMoviesPublished = res.map({ MovieCategoriesModel(id: $0.id, imageURL: $0.imageUrl, category: $0.category, movieTag: $0.movieTag) })
    }
  }
  
}
