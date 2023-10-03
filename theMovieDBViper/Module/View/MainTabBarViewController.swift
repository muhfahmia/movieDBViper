//
//  MainTabBarController.swift
//  movieDBMVVM
//
//  Created by Muhammad Fahmi on 19/09/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        configureController()
    }
    
    private func configureController() {
        view.backgroundColor = .white
        let movieListVC = MovieListRouter.entryPoint()
        
        let movies = setupNavigationController(title: "Movies", inactiveImage: UIImage(systemName: "film")!, activeImage: UIImage(systemName: "film.fill")!, rootViewController: movieListVC)
//        let tvShows = setupNavigationController(title: "TV Shows", inactiveImage: UIImage(systemName: "tv")!, activeImage: UIImage(systemName: "tv.fill")!, rootViewController: TVShowsController())
        
        setViewControllers([movies], animated: true)
        
    }
    
    private func setupNavigationController(title: String, inactiveImage: UIImage, activeImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav =  UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = inactiveImage
        nav.tabBarItem.badgeColor = .red
        nav.tabBarItem.selectedImage = activeImage
        nav.tabBarItem.title = title
        return nav
    }
    
    
}
