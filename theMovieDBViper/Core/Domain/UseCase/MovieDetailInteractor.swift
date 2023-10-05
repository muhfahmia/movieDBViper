//
//  MovieDetailInteractor.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation

protocol MovieDetailUseCase {
    func getMovieDetail(withID id: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
    func addMovieFavorite(with movie: MovieModel,completion: @escaping (Result<Bool, Error>) -> Void)
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void)
}

class MovieDetailInteractor: MovieDetailUseCase {
    
    private let movieDetailRepository: MovieDetailRepository
    
    init(movieDetailRepository: MovieDetailRepository) {
        self.movieDetailRepository = movieDetailRepository
    }
    
    func getMovieDetail(withID id: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        movieDetailRepository.getMovieDetail(withID: id) { result in
            completion(result)
        }
    }
    
    func addMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        movieDetailRepository.addMovieFavorite(with: movie) { result in
            completion(result)
        }
    }
    
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        movieDetailRepository.getMovieFavorite { result in
            completion(result)
        }
    }
    
}
