//
//  MovieListPresenter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 28/09/23.
//

import Foundation
import UIKit

protocol MovieListPresenterProtocol {
    var movieListView: MovieListViewProtocol? { get set }
    var movieListRouter: MovieListRouterProtocol? { get set }
    
    var totalPage: Int { get set }
    var totalMovie: Int { get set }
    var page: Int { get set }
    var typeMovie: String { get set }
    var movies: [MovieModel] { get set }
    
    func getMovieList()
    func pushToDetail(indexPath indexPath: IndexPath)

}

class MovieListPresenter: MovieListPresenterProtocol {

    private let movieListUseCase: MovieListUseCase
    
    var movieListView: MovieListViewProtocol?
    var movieListRouter: MovieListRouterProtocol?
    
    var movies: [MovieModel] = []
    var totalPage = 0
    var totalMovie = 0
    var page = 0
    var typeMovie: String = Endpoints.movieDB.moviesTopRated.url
    
    init(movieListUseCase: MovieListUseCase, movieListView: MovieListViewProtocol) {
        self.movieListUseCase = movieListUseCase
        self.movieListView = movieListView
    }
    
    func pushToDetail(indexPath index: IndexPath) {
        movieListRouter?.routeToDetail(on: movieListView!)
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
                    
                    self.movieListView?.movieListUpdateSuccess(with: moviesMapping)
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            self.movieListView?.movieListUpdateFail()
        }
    }
}
