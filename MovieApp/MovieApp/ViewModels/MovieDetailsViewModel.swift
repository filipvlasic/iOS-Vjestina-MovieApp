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
    apiClient.getMovieDetails(with: id) { [weak self] amMovieDetails, error in
      if let error { print(error) }
      
      guard let amMovieDetails else { return }
      self?.details = MovieDetailsModel(
        categories: amMovieDetails.categories,
        crewMembers: amMovieDetails.crewMembers.map({ CrewMember(name: $0.name, role: $0.role) }),
        id: amMovieDetails.id,
        duration: amMovieDetails.duration,
        year: amMovieDetails.year,
        rating: amMovieDetails.rating,
        imageURL: amMovieDetails.imageURL,
        name: amMovieDetails.name,
        releaseDate: amMovieDetails.releaseDate,
        summary: amMovieDetails.summary)
    }
  }
}
