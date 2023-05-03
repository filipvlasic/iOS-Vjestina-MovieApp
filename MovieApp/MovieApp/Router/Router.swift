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
  
  func start(in window: UIWindow?) {

    let movieCategoriesVC = createMovieCategoriesVC()
    navigationController.setViewControllers([movieCategoriesVC], animated: true)
    let favoritesVC = createFavoritesVC()
    let tabBarController = createTabBarController(with: [navigationController, favoritesVC])
    
//    let movieListVC = MovieListViewController(router: self)
//    movieListVC.title = "Movie List"
//    navigationController.setViewControllers([movieListVC], animated: true)
    
    window?.rootViewController = tabBarController
//    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  private func createMovieCategoriesVC() -> MovieCategoriesViewController {
    let movieCategoriesVC = MovieCategoriesViewController(router: self)
    movieCategoriesVC.tabBarItem = UITabBarItem(
      title: "Movie List",
      image: .tabMovieListImage,
      selectedImage: .tabMovieListSelectedImage)
    return movieCategoriesVC
  }
  
  private func createFavoritesVC() -> FavoritesViewController {
    let favoritesVC = FavoritesViewController()
    favoritesVC.tabBarItem = UITabBarItem(
      title: "Favorites",
      image: .tabFavoritesImage,
      selectedImage: .tabFavoritesSelectedImage)
    return favoritesVC
  }
  
  private func createTabBarController(with controllers: [UIViewController]) -> UITabBarController {
    let tabBarController = UITabBarController()
    tabBarController.tabBar.tintColor = .label
    tabBarController.viewControllers = controllers
    return tabBarController
  }
  
  func showMovieDetails(with id: Int) {
    let movieDetailsVC = MovieDetailsViewController(id: id)
    movieDetailsVC.title = "Movie Details"
    navigationController.pushViewController(movieDetailsVC, animated: true)
  }
}
