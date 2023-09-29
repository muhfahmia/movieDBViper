//
//  MovieListMapper.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import Foundation
final class MovieListMapper {
    
    static func mapMovieListToDomains(input movie: [MovieResponse]) -> [MovieModel] {
        return movie.map{ movie in
            return MovieModel(id: movie.id, title: movie.title, releaseDate: movie.releaseDate, posterImage: movie.posterImage ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
        }
    }
    
}
