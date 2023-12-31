//
//  MovieDetailRepository.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation

protocol MovieFavoriteRepositoryProtocol {
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func deleteMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void)
}

class MovieFavoriteRepository: MovieFavoriteRepositoryProtocol {
    
    private let movieFavoSource: MovieFavoriteDataSource
    
    init(movieFavoSource: MovieFavoriteDataSource) {
        self.movieFavoSource = movieFavoSource
    }
    
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        movieFavoSource.getMovieFavorite { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        movieFavoSource.deleteMovieFavorite(with: movie) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
