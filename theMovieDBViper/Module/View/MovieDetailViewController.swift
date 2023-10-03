//
//  MovieDetailViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 02/10/23.
//

import Foundation
import UIKit

protocol MovieDetailProtocol {
    var movieDetailPresenter: MovieDetailPresenterProtocol? { get set }
}

class MovieDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGrayCustom
    }
}
