//
//  API.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import Foundation

struct APIConfig {

    static let baseUrl = "https://api.themoviedb.org/3/"
    static let apiKey = "fbb7a74bee5c071d2aaf776704e2b328"
    static let apiBearer = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYmI3YTc0YmVlNWMwNzFkMmFhZjc3NjcwNGUyYjMyOCIsInN1YiI6IjYzNGQ1NmU5MTJlYjg5MDA4MmM1M2U2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0FpLGgeCav4lO0rq2DCmggyPWZqFdIIojYlP8PKdUmU"

}
enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    }
  }

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
    
  enum movieDB: Endpoint {
      
    case moviesPopular
    case moviesTopRated
    case moviesUpComing
    case moviesNowPlaying
    case movieImage
      
    public var url: String {
        switch self {
        case .moviesPopular: return "\(APIConfig.baseUrl)movie/popular"
        case .moviesTopRated: return "\(APIConfig.baseUrl)movie/top_rated"
        case .moviesNowPlaying: return "\(APIConfig.baseUrl)movie/now_playing"
        case .moviesUpComing: return "\(APIConfig.baseUrl)movie/upcoming"
        case .movieImage: return "https://image.tmdb.org/t/p/w200"
        }
    }
  }
}
