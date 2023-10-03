//
//  MovieDetailResponse.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation

struct MovieDetailResponse: Codable {
    let id: Int
    let backdropPath: String
    let title: String
    let genres: [GenresReponse]
    let description: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case genres
        case description = "overview"
        case releaseDate = "release_date"
    }
}

struct GenresReponse: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
