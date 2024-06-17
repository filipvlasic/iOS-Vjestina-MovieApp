//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 20.05.2023..
//

import Foundation

class MovieDetailsViewModel {
  @Published private(set) var details: MovieDetailsModel!
  
  private var apiClient: APIClient!
  
  init(apiClient: APIClient!) {
    self.apiClient = apiClient
  }
  
  func fetchMovieDetails(with id: Int) {
    Task.init {
      let res = await apiClient.getMovieDetails(with: id)
      guard let res else { return }
      
      details = MovieDetailsModel(
        categories: res.categories,
        crewMembers: res.crewMembers.map({ CrewMember(name: $0.name, role: $0.role) }),
        id: res.id,
        duration: res.duration,
        year: res.year,
        rating: res.rating,
        imageUrl: res.imageUrl,
        name: res.name,
        releaseDate: res.releaseDate,
        summary: res.summary)
    }
    
  }
}
