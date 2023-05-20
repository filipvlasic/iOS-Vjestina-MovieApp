//
//  NativeAPIClient.swift
//  MovieApp
//
//  Created by Filip Vlašić on 20.05.2023..
//

import UIKit
import MovieAppData

struct MockAPIClient {
  func getFreeToWatchMovies() async -> [AMMovie]? {
    return nil
  }
  
  
  func getFreeToWatchMovies(completion: @escaping ([AMMovie]?, Error?) -> Void) {
    let movies = MovieUseCase().freeToWatchMovies.map { AMMovie(id: $0.id, imageUrl: $0.imageUrl, name: $0.name, summary: $0.summary, year: 2000) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(movies, nil)
    }
  }
  
  func getPopularMovies(completion: @escaping ([AMMovie]?, Error?) -> Void) {
    let movies = MovieUseCase().popularMovies.map { AMMovie(id: $0.id, imageUrl: $0.imageUrl, name: $0.name, summary: $0.summary, year: 2000) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(movies, nil)
    }
  }
  
  func getTrendingMovies(completion: @escaping ([AMMovie]?, Error?) -> Void) {
    let movies = MovieUseCase().trendingMovies.map { AMMovie(id: $0.id, imageUrl: $0.imageUrl, name: $0.name, summary: $0.summary, year: 2000) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(movies, nil)
    }
  }
  
  func getAllMovies(completion: @escaping ([AMMovie]?, Error?) -> Void) {
    let movies = MovieUseCase().allMovies.map { AMMovie(id: $0.id, imageUrl: $0.imageUrl, name: $0.name, summary: $0.summary, year: 2000) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(movies, nil)
    }
  }
  
  func getMovieDetails(with id: Int, completion: @escaping (AMMovieDetails?, Error?) -> Void) {
    let movieDetails = MovieUseCase().getDetails(id: id).map { AMMovieDetails(
      categories: ["Test", "Test"],
      crewMembers: [
        AMCrewMember(name: "Filip", role: "Test"),
        AMCrewMember(name: "Filip", role: "Test"),
        AMCrewMember(name: "Filip", role: "Test"),
        AMCrewMember(name: "Filip", role: "Test"),
      ],
      id: $0.id,
      duration: $0.duration,
      year: $0.year,
      rating: $0.rating,
      imageUrl: $0.imageUrl,
      name: $0.name,
      releaseDate: $0.releaseDate,
      summary: $0.summary) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(movieDetails, nil)
    }
  }
  
}
