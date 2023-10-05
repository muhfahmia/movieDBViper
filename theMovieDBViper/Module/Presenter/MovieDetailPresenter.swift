//
//  MovieDetailPresenter.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 02/10/23.
//

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol {
    var movieDetailView: MovieDetailProtocol? { get set }
    
    var movie: MovieModel? { get set }
    
    func getMovieDetail()
    
    func addMovieFavorite()
    
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var movieDetailView: MovieDetailProtocol?
    
    private let movieDetailInteractor: MovieDetailUseCase
    
    var movie: MovieModel?
    
    init(movieDetailInteractor: MovieDetailUseCase) {
        self.movieDetailInteractor = movieDetailInteractor
    }
    
    func getMovieDetail() {
        movieDetailInteractor.getMovieDetail(withID: self.movie?.id ?? 0) { result in
            switch result {
            case .success(let data):
                self.movie = MovieModel(id: data.id, title: data.title, releaseDate: data.releaseDate, posterImage: data.backdropPath, description: data.description)
                self.movieDetailView?.movieUpdateSuccess(with: self.movie)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func addMovieFavorite() {
        movieDetailInteractor.addMovieFavorite(with: self.movie!) { result in
            switch result {
            case .success(let data):
                print(data)
                if data == true {
                    self.movieDetailView?.movieUpdateFavoriteSuccess()
                }else{
                    self.movieDetailView?.movieUpdateFavoriteFailed()
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func getMovieFavorite() {
        movieDetailInteractor.getMovieFavorite() { result in
            switch result {
            case .success(_):
                print("success get movie favorite")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
