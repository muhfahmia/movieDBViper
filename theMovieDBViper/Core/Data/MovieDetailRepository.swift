//
//  MovieDetailRepository.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation

protocol MovieDetailRepositoryProtocol {
    func getMovieDetail(withID id: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
    func addMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void)
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void)
}

class MovieDetailRepository: MovieDetailRepositoryProtocol {
    
    private let movieDetailSource: MovieDetailDataSource
    private let movieDetailFavorite: MovieFavoriteDataSource
    
    init(movieDetailSource: MovieDetailDataSource, movieDetailFavorite: MovieFavoriteDataSource) {
        self.movieDetailSource = movieDetailSource
        self.movieDetailFavorite = movieDetailFavorite
    }
    
    func getMovieDetail(withID id: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        movieDetailSource.getMoviesDetailFromSource(withID: id) { result in
            switch result {
            case  .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        movieDetailFavorite.addMovieFavorite(with: movie) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        movieDetailFavorite.getMovieFavorite { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
