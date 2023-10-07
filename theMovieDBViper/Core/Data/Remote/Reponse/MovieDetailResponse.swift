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
    var vote: Double? = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case genres
        case description = "overview"
        case releaseDate = "release_date"
        case vote = "vote_average"
    }
}

struct GenresReponse: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
