//
//  ViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import UIKit
import SkeletonView

protocol MovieFavoriteViewProtocol {
    func updateSuccessDelete(indexPath: IndexPath)
    func updateSuccessMovies(with movies: [MovieModel])
    
    var movieFavoPresenter: MovieFavoritePresenterProtocol? { get set }
}

class MovieFavoriteViewController: UIViewController, MovieFavoriteViewProtocol {

    enum sectionFavo: Int, CaseIterable {
        case moviFavo
    }
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        movieFavoPresenter?.getMovieFavorite()
    
    }
    
    func movieListUpdateFail() {
        print("all data reloaded")
    }
    
    func updateSuccessMovies(with movies: [MovieModel]) {
        self.movieListSnapshot.appendItems(movies, toSection: .moviFavo)
        self.movieListDataSource.apply(movieListSnapshot, animatingDifferences: false)
    }
    
    func updateSuccessDelete(indexPath: IndexPath) {
        let itemToDelete = self.movieListSnapshot.itemIdentifiers[indexPath.item]
        let runItemToDelete = self.movieListSnapshot.deleteItems([itemToDelete])
        self.movieListDataSource.apply(self.movieListSnapshot,animatingDifferences: true)
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
