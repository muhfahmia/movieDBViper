//
//  MovieDetailRouter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation
import CoreData

protocol MovieDetailRouterProtocol {
    func routeToDetail(on view: MovieListViewProtocol, with movie: MovieModel)
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    static let movieDetailRouterShared: MovieDetailRouter = MovieDetailRouter()
    
    func routeToDetail(on view: MovieListViewProtocol, with movie: MovieModel) {
        let detailVC = MovieDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        let detailInteractor = MovieDetailInteractor(movieDetailRepository: provideMovieDetailSource())
        let detailPresenter = MovieDetailPresenter(movieDetailInteractor: detailInteractor)
        let movieListVC = view as? MovieListViewController
        detailVC.movieDetailPresenter = detailPresenter
        detailVC.movieDetailPresenter?.movieDetailView = detailVC
        detailVC.movieDetailPresenter?.movie = movie
        
        //push detail
        movieListVC?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func provideMovieDetailSource() -> MovieDetailRepository {
        let movieFavoriteSource = MovieFavoriteDataSource()
        
        return MovieDetailRepository(movieDetailSource: MovieDetailDataSource.sharedMovieDetailInstance, movieDetailFavorite: movieFavoriteSource)
    }
}
