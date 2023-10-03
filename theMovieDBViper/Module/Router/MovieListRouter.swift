//
//  MovieListRouter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 02/10/23.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol {
    static func entryPoint() -> UIViewController
    
    func routeToDetail(on view: MovieListViewProtocol)
}

class MovieListRouter: MovieListRouterProtocol {
    static func entryPoint() -> UIViewController {
        
        let movieListVC = MovieListViewController()
        let movieListRouter = MovieListRouter()
        let di = MovieListDI.init().provideMovieList()
        let movieListUseCase = MovieListPresenter(movieListUseCase: di, movieListView: movieListVC)
        movieListVC.movieListPresenter = movieListUseCase
        movieListVC.movieListPresenter?.movieListRouter = movieListRouter
        return movieListVC
    }
    
    func routeToDetail(on view: MovieListViewProtocol) {
        let detailVC = MovieDetailViewController()
        let movieListVC = view as? MovieListViewController
        movieListVC?.navigationController?.pushViewController(detailVC, animated: true)
//        print("to detail")
    }
    
}
