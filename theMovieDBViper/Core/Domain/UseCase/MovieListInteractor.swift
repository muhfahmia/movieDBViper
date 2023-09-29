//
//  MovieListInteractor.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 28/09/23.
//

import Foundation

protocol MovieListUseCase {
    func getMovieList(typeMovie type: String, forPage page: Int, completion: @escaping (Result<MovieListReponse, Error>) -> Void)
}

class MovieListInteractor: MovieListUseCase {
    
    private let repository: MovieListRepositoryProtocol
    
    required init(repository: MovieListRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovieList(typeMovie type: String, forPage page: Int, completion: @escaping (Result<MovieListReponse, Error>) -> Void) {
        repository.getMovieList(typeMovie: type, forPage: page) {
            result in completion(result)
        }
    }
    
}
