//
//  ViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import UIKit
import SkeletonView

protocol MovieListViewProtocol {
    var movieListPresenter: MovieListPresenterProtocol? { get set }
    func movieListUpdateSuccess(with movies: [MovieModel])
    func movieListUpdateFail()
}

class MovieListViewController: UIViewController, MovieListViewProtocol {
    
    var movieListPresenter: MovieListPresenterProtocol?
    
    enum sectionLayout: Int, CaseIterable {
        case movieList
    }

    var collectionView: UICollectionView!
    var movieListDataSource: UICollectionViewDiffableDataSource<sectionLayout, MovieModel>!
    var movieListSnapshot = NSDiffableDataSourceSnapshot<sectionLayout, MovieModel>()
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black, // Change the color to your desired color
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popular Movies"
    
        setupCollectionView()
        setupCellRegister()
        setupCollectionViewDataSource()
        
        movieListPresenter?.getMovieList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.titleTextAttributes = titleAttributes
//        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
    
    }
    
    func movieListUpdateSuccess(with movies: [MovieModel]) {
        self.movieListSnapshot.appendItems(movies, toSection: .movieList)
        self.movieListDataSource.apply(movieListSnapshot, animatingDifferences: false)
    }
    
    func movieListUpdateFail() {
        print("all data reloaded")
    }
    
    
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let countMovies = movieListSnapshot.numberOfItems
        if indexPath.row == countMovies - 1 {
            movieListPresenter?.getMovieList()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sectionLayout(rawValue: indexPath.section)
        switch section {
        case .movieList:
            movieListPresenter?.pushToDetail(indexPath: indexPath)
        case .none:
            print(indexPath.row)
        }
    }
}


//setup custom function

extension MovieListViewController {
    
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
        self.movieListDataSource = UICollectionViewDiffableDataSource<sectionLayout, MovieModel>(
            collectionView: self.collectionView,
            cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as! MovieListCollectionViewCell
                cell.configure(with: movie, tooltip: "no", indexPath: indexPath)
                self.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
                return cell
            }
        )
        //setup snapshot
        self.movieListSnapshot.appendSections([.movieList])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section: Int, env) -> NSCollectionLayoutSection in
            let sectionLayout = sectionLayout(rawValue: section)
            if sectionLayout == .movieList {
                return self.collectionView.movieListSection()
            }else{
                return self.collectionView.movieListSection()
            }
        }
    }
}
