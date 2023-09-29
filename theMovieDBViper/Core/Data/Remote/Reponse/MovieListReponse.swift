//
//  MovieListReponse.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import Foundation

struct MovieListReponse: Codable {
    let page: Int
    let movies: [MovieResponse]
    let totalPage: Int
    let totalResult: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPage = "total_pages"
        case totalResult = "total_results"
    }
}

struct MovieResponse: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    var posterImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterImage = "poster_path"
    }
    init(id: Int, title: String, releaseDate: String, posterImage: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        if self.posterImage == nil {
            self.posterImage = "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"
        }
        self.posterImage = posterImage
    }
}
