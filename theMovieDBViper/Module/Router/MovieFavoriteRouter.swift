//
//  MovieFavoriteRouter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 05/10/23.
//

import Foundation
import UIKit

protocol MovieFavoriteRouterProtocol {
   static func entryPoint() -> UIViewController
}

class MovieFavoriteRouter: MovieFavoriteRouterProtocol
{
    static func entryPoint() -> UIViewController {
        let provideDataSource = MovieFavoriteDataSource.sharedMovieFavoSource
        let provideRepo = MovieFavoriteRepository(movieFavoSource: provideDataSource)
        let movieFavoRepo = MovieFavoriteInteractor(movieFavoRepo: provideRepo)
        let movieFavoVC = MovieFavoriteViewController()
        let movieFavoPresenter = MovieFavoritePresenter(movieFavoriteInteractor: movieFavoRepo)
        movieFavoVC.movieFavoPresenter = movieFavoPresenter
        movieFavoVC.movieFavoPresenter?.movieFavoriteView = movieFavoVC
        return movieFavoVC
    }
}
