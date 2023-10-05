//
//  MovieFavoritePresenter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 05/10/23.
//

import Foundation

protocol MovieFavoritePresenterProtocol {
    var movieFavoriteView: MovieFavoriteViewProtocol? { get set }
    var movies: [MovieModel] { get set }
    
    func getMovieFavorite()
}

class MovieFavoritePresenter: MovieFavoritePresenterProtocol {
    
    var movieFavoriteView: MovieFavoriteViewProtocol?
    
    var movies: [MovieModel] = []
    
    
    private let movieFavoriteInteractor: MovieFavoriteUseCase
    
    init(movieFavoriteInteractor: MovieFavoriteUseCase) {
        self.movieFavoriteInteractor = movieFavoriteInteractor
    }
    
    func getMovieFavorite() {
        movieFavoriteInteractor.getMovieFavorite{ result in
            switch result {
            case .success(let data):
                self.movieFavoriteView?.updateSuccessMovies(with: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
