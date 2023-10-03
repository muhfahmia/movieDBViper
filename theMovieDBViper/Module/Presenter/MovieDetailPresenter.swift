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
//    var movieDetailInteractor: MovieDetailInteractorProtocol? { get set }
//    var movieDetailRouter: MovieDetailRouterProtocol? { get set }
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var movieDetailView: MovieDetailProtocol?
}
