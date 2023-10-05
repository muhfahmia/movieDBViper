//
//  MovieFavoriteInteractor.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 05/10/23.
//

import Foundation

protocol MovieFavoriteUseCase {
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void)
}

class MovieFavoriteInteractor: MovieFavoriteUseCase {
    
    private let movieFavoRepo: MovieFavoriteRepositoryProtocol
    
    init(movieFavoRepo: MovieFavoriteRepositoryProtocol) {
        self.movieFavoRepo = movieFavoRepo
    }
    
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        movieFavoRepo.getMovieFavorite{ result in
            completion(result)
        }
    }
    
}
