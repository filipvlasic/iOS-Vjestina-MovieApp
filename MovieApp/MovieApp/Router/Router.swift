//
//  Router.swift
//  MovieApp
//
//  Created by Filip Vlašić on 24.04.2023..
//

import UIKit

class Router {
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let movieCategoriesVC = MovieCategoriesViewController(router: self)
    movieCategoriesVC.tabBarItem = UITabBarItem(
      title: "Movie List",
      image: .tabMovieListImage,
      selectedImage: .tabMovieListSelectedImage)
    
    navigationController.setViewControllers([movieCategoriesVC], animated: true)
  }
  
  func showMovieDetails(with id: Int) {
    let movieDetailsVC = MovieDetailsViewController(id: id)
    movieDetailsVC.title = "Movie Details"
    navigationController.pushViewController(movieDetailsVC, animated: true)
  }
}
