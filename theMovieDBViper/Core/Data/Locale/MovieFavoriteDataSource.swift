//
//  MovieFavorite.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 03/10/23.
//

import Foundation
import CoreData

protocol MovieFavoriteDataSourceProtocol {
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func addMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void)
}

class MovieFavoriteDataSource: MovieFavoriteDataSourceProtocol {
    let container = NSPersistentContainer(name: "MovieModel")
    private let context: NSManagedObjectContext
    private let movieEntity: NSEntityDescription
    
    static let sharedMovieFavoSource: MovieFavoriteDataSource = MovieFavoriteDataSource()
    
    init() {
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.context = container.viewContext
        self.movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: self.context)!
    }
    
    func addMovieFavorite(with movie: MovieModel, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieID = \(movie.id)")
        do {
            let movies = try context.fetch(fetchRequest).count
            if movies == 0 {
                let movieObject = NSManagedObject(entity: self.movieEntity, insertInto: self.context)
                movieObject.setValue(movie.id, forKeyPath: "movieID")
                movieObject.setValue(movie.title, forKeyPath: "title")
                movieObject.setValue(movie.posterImage, forKeyPath: "posterImage")
                movieObject.setValue(movie.releaseDate, forKeyPath: "releaseDate")
                do {
                    try context.save()
                    completion(.success(true))
                } catch {
                    print("Error saving movie: \(error)")
                    completion(.failure(error))
                }
            }else{
                completion(.success(false))
            }
        } catch {
            print("Error fetch check movie: \(error)")
            completion(.failure(error))
        }
    }
    
    func getMovieFavorite(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
            let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
            do {
                let movies = try context.fetch(fetchRequest)
                var moviesModel: [MovieModel] = []
                for movie in movies {
                    let movieID = movie.value(forKey: "movieID") as? Int64 ?? Int64(0)
                    let movieTitle = movie.value(forKey: "title") as? String ?? ""
                    let moviePoster = movie.value(forKey: "posterImage") as? String ?? ""
                    let movieReleaseDate = movie.value(forKey: "releaseDate") as? String ?? ""
                    let mv = MovieModel(id: Int(Int64(movieID)), title: movieTitle, releaseDate: movieReleaseDate, posterImage: moviePoster)
                    moviesModel.append(mv)
                }
                completion(.success(moviesModel))
            } catch {
                completion(.failure(error))
            }
        }
    
}
