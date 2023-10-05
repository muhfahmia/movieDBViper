//
//  MovieDetailDataSource.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation
import Alamofire

protocol MovieDetailDataSourceProtocol {
    func getMoviesDetailFromSource(withID id: Int, completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void)
}

final class MovieDetailDataSource: MovieDetailDataSourceProtocol {
    
    static let sharedMovieDetailInstance: MovieDetailDataSource = MovieDetailDataSource()
    
    func getMoviesDetailFromSource(withID id: Int, completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void) {
        guard let url = URL(string: Endpoints.movieDB.movieDetail(id: id).url)
        else { return }
        
        let param = [
            "api_key": APIConfig.apiKey
        ] as [String : Any]
        
        AF.request(url, method: .get,parameters: param)
        .validate()
        .responseDecodable(of: MovieDetailResponse.self) {
            response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
