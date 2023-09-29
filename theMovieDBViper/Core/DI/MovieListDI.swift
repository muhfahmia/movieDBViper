//
//  MovieListDI.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 28/09/23.
//

import Foundation

final class MovieListDI: NSObject {
    private func provideRepository() -> MovieListRepository {
        let remoteMovieList: MovieListDataSource = MovieListDataSource.sharedInstance
        return MovieListRepository(dataSource: remoteMovieList)
    }
    
    func provideMovieList() -> MovieListUseCase {
        let repository = provideRepository()
        return MovieListInteractor(repository: repository)
    }
}
