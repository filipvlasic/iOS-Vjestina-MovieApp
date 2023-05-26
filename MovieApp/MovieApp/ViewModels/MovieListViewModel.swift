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
    Task.init {
      let res = await apiClient.getAllMovies()
      guard let res else { return }
      allMovies = res.map({ MovieListModel(id: $0.id, imageURL: $0.imageUrl, name: $0.name, summary: $0.summary) })
    }
  }
}
