//
//  ViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import UIKit
import SkeletonView

protocol MovieFavoriteViewProtocol {
    func updateSuccessDelete(with movie: MovieModel, indexPath: IndexPath)
    func updateSuccessMovies(with movies: [MovieModel])
    
    var movieFavoPresenter: MovieFavoritePresenterProtocol? { get set }
}

class MovieFavoriteViewController: UIViewController, MovieFavoriteViewProtocol {

    enum sectionFavo: Int, CaseIterable {
        case moviFavo
    }
    
    let movieUnknown: UILabel = {
        let ml = UILabel()
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.textColor = .black
        ml.font = UIFont(name: "Arial", size: 16)
        ml.text = "Data Movie Favorite tidak ada"
        ml.numberOfLines = 0
        ml.isHidden = true
        return ml
    }()
    
    var movieFavoPresenter: MovieFavoritePresenterProtocol?

    var collectionView: UICollectionView!
    var movieListDataSource: UICollectionViewDiffableDataSource<sectionFavo, MovieModel>!
    var movieListSnapshot = NSDiffableDataSourceSnapshot<sectionFavo, MovieModel>()
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black, // Change the color to your desired color
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        setupCollectionView()
        setupCellRegister()
        setupCollectionViewDataSource()
        
        collectionView.addSubview(movieUnknown)
        movieUnknown.center(inView: collectionView)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        movieFavoPresenter?.getMovieFavorite()
        let mvmdl = self.movieListSnapshot.itemIdentifiers(inSection: .moviFavo).count
        if mvmdl == 0 {
            movieUnknown.isHidden = false
        }else{
            movieUnknown.isHidden = true
        }
    }
    
    func movieListUpdateFail() {
        print("all data reloaded")
    }
    
    func updateSuccessMovies(with movies: [MovieModel]) {
        self.movieListSnapshot.appendItems(movies, toSection: .moviFavo)
        self.movieListDataSource.apply(movieListSnapshot, animatingDifferences: true)
    }
    
    func updateSuccessDelete(with movie: MovieModel, indexPath: IndexPath) {
        let movieModel = self.movieListSnapshot.itemIdentifiers(inSection: .moviFavo)
        let itemToDelete = movie
        let filtersItem  = movieModel.filter { $0.id == itemToDelete.id }
        if filtersItem.count > 0 {
            self.movieListSnapshot.deleteItems([itemToDelete])
            self.movieListDataSource.apply(self.movieListSnapshot,animatingDifferences: true)
        }else{
            print("items not found")
        }
        
        let movieMdel = self.movieListSnapshot.itemIdentifiers(inSection: .moviFavo).count
        if movieMdel == 0 {
            movieUnknown.isHidden = false
        }
        
    }
}

extension MovieFavoriteViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let countMovies = movieListSnapshot.numberOfItems
        if indexPath.row == countMovies - 1 {
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}


//setup custom function

extension MovieFavoriteViewController {
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createLayout())
        collectionView.backgroundColor = .lightGrayCustom
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor)
    }
    
    func setupCellRegister() {
        collectionView.register(FilterMovieCollectionViewCell.self, forCellWithReuseIdentifier: FilterMovieCollectionViewCell.identifier)
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    }
    
    func setupCollectionViewDataSource() {
        self.movieListDataSource = UICollectionViewDiffableDataSource<sectionFavo, MovieModel>(
            collectionView: self.collectionView,
            cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as! MovieListCollectionViewCell
                cell.configure(with: movie, tooltip: "yes", indexPath: indexPath)
                cell.movieFavoPresenter = self.movieFavoPresenter
                self.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
                return cell
            }
        )
        //setup snapshot
        self.movieListSnapshot.appendSections([.moviFavo])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section: Int, env) -> NSCollectionLayoutSection in
            let sectionLayout = sectionFavo(rawValue: section)
            if sectionLayout == .moviFavo {
                return self.collectionView.movieListSection()
            }else{
                return self.collectionView.movieListSection()
            }
        }
    }
}
