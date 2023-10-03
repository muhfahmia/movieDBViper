//
//  MovieDataSource.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import Foundation
import Alamofire

protocol MovieListDataSourceProtocol {
    func getMovieListFromSource(typeMovie: String, forPage page: Int, completion: @escaping (Result<MovieListReponse, AFError>) -> Void)
}

class MovieListDataSource: MovieListDataSourceProtocol {
    
    static let sharedInstance: MovieListDataSource = MovieListDataSource()
    
    func getMovieListFromSource(typeMovie type: String, forPage page: Int, completion: @escaping (Result<MovieListReponse, AFError>) -> Void) {
        guard let url = URL(string: type)
        else { return }
        
        let param = [
            "api_key": APIConfig.apiKey,
            "page": page
        ] as [String : Any]
        
        AF.request(url, method: .get,parameters: param)
        .validate()
        .responseDecodable(of: MovieListReponse.self) {
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
