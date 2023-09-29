//
//  MovieListPresenter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 28/09/23.
//

import Foundation

protocol MovieListPresenterToViewProtocol {
    func getMovieList()
    var totalPage: Int { get set }
    var totalMovie: Int { get set }
    var page: Int { get set }
    var typeMovie: String { get set }
    var movies: [MovieModel] { get set }
}

class MovieListPresenter: MovieListPresenterToViewProtocol {
    

    private let movieListUseCase: MovieListUseCase
    
    var movieListView: MovieListViewToPresenterProtocol?
    
    var movies: [MovieModel] = []
    var totalPage = 0
    var totalMovie = 0
    var page = 0
    var typeMovie: String = Endpoints.movieDB.moviesNowPlaying.url
    
    init(movieListUseCase: MovieListUseCase, movieListView: MovieListViewToPresenterProtocol) {
        self.movieListUseCase = movieListUseCase
        self.movieListView = movieListView
        getMovieList()
    }

    
    func getMovieList() {
        if self.page <= self.totalPage || self.page == 0 {
            self.page += 1
            print("pages: \(self.page)")
            movieListUseCase.getMovieList(typeMovie: self.typeMovie, forPage: self.page) {
                result in
                switch result {
                case .success(let data):
                    let moviesMapping = MovieListMapper.mapMovieListToDomains(input: data.movies)
                    self.movies.append(contentsOf: moviesMapping)
                    self.page = data.page
                    self.totalPage = data.totalPage
                    self.totalMovie = data.totalResult
                    self.movieListView?.movieListUpdateSuccess()
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            self.movieListView?.movieListUpdateFail()
        }
    }
}
