//
//  Router.swift
//  MovieApp
//
//  Created by Filip Vlašić on 24.04.2023..
//

import UIKit

class Router {
  private let navigationController: UINavigationController
  private let apiClient = NativeAPIClient()
  
  init() {
    self.navigationController = UINavigationController()
  }
  
  func start(in window: UIWindow?) {

    let movieCategoriesVC = createMovieCategoriesVC()
    navigationController.setViewControllers([movieCategoriesVC], animated: true)
    let favoritesVC = createFavoritesVC()
    let tabBarController = createTabBarController(with: [navigationController, favoritesVC])
    
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
  }
  
  private func createMovieCategoriesVC() -> MovieCategoriesViewController {
    let movieCategoriesVC = MovieCategoriesViewController(router: self, viewModel: MovieCategoriesViewModel(apiClient: apiClient))
    movieCategoriesVC.tabBarItem = UITabBarItem(
      title: "Movie List",
      image: .tabMovieListImage,
      selectedImage: .tabMovieListSelectedImage)
    return movieCategoriesVC
  }
  
  private func createFavoritesVC() -> FavoritesViewController {
    let favoritesVC = FavoritesViewController(router: self, apiClient: apiClient)
    favoritesVC.tabBarItem = UITabBarItem(
      title: "Favorites",
      image: .heart,
      selectedImage: .heartFill)
    return favoritesVC
  }
  
  private func createTabBarController(with controllers: [UIViewController]) -> UITabBarController {
    let tabBarController = UITabBarController()
    tabBarController.tabBar.tintColor = .label
    tabBarController.viewControllers = controllers
    return tabBarController
  }
  
  func showMovieDetails(with id: Int) {
    let movieDetailsVC = MovieDetailsViewController(id: id, viewModel: MovieDetailsViewModel(apiClient: apiClient))
    movieDetailsVC.title = "Movie Details"
    navigationController.pushViewController(movieDetailsVC, animated: true)
  }
}
