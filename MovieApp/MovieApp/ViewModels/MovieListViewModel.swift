//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 20.05.2023..
//

import UIKit

class MovieListViewModel {
  @Published private(set) var allMovies: [MovieListModel] = .init()
  
  private var apiClient: APIClient!
  
  init(apiClient: APIClient!) {
    self.apiClient = apiClient
  }
  
  func fetchMovies() {
    apiClient.getAllMovies { [weak self] amMovie, error in
      if let error { print(error) }
      
      guard let amMovie else { return }
      self?.allMovies = amMovie.map({ MovieListModel(id: $0.id, imageURL: $0.imageURL, name: $0.name, summary: $0.summary) })
    }
  }
}
