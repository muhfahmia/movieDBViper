//
//  MovieModel.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import Foundation

struct MovieModel: Hashable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterImage: String
    var description: String?
}
