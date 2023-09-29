//
//  MovieListRepository.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import Foundation

protocol MovieListRepositoryProtocol {
    func getMovieList(typeMovie type: String, forPage page: Int, completion: @escaping (Result<MovieListReponse, Error>) -> Void)
}

class MovieListRepository: MovieListRepositoryProtocol {
    
    private let movieListDataSource: MovieListDataSourceProtocol
    
    init(dataSource: MovieListDataSourceProtocol) {
        self.movieListDataSource = dataSource
    }
    
    func getMovieList(typeMovie type: String, forPage page: Int, completion: @escaping (Result<MovieListReponse, Error>) -> Void) {
        movieListDataSource.getMovieListFromSource(typeMovie: type, forPage: page, completion: { remoteResponse in
            switch remoteResponse {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
