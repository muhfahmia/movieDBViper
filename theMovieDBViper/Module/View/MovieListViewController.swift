//
//  ViewController.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 27/09/23.
//

import UIKit
import SkeletonView

protocol MovieListViewToPresenterProtocol {
    func movieListUpdateSuccess()
    func movieListUpdateFail()
}

class MovieListViewController: UIViewController, MovieListViewToPresenterProtocol {
    
    var movieListPresenter: MovieListPresenterToViewProtocol?
    
    enum sectionLayout: Int, CaseIterable {
        case filterMovie
        case movieList
    }

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Movies"
        
        setupCollectionView()
        setupCellRegister()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    func movieListUpdateSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: 1))
        }
        print("update dari view")
    }
    
    func movieListUpdateFail() {
        print("all data reloaded")
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let countMovies = movieListPresenter?.movies.count ?? 0
        if indexPath.row == countMovies - 1 {
            movieListPresenter?.getMovieList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return movieListPresenter?.movies.count ?? 0
        default:
            return 5
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        
        if section == 1 {
            let movie = movieListPresenter?.movies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as! MovieListCollectionViewCell
            cell.configure(with: movie)
            self.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterMovieCollectionViewCell.identifier, for: indexPath) as! FilterMovieCollectionViewCell
            return cell
        }
        
    }
}


//setup custom function

extension MovieListViewController {
    func setupCellRegister() {
        collectionView.register(FilterMovieCollectionViewCell.self, forCellWithReuseIdentifier: FilterMovieCollectionViewCell.identifier)
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    }
 
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createLayout())
        collectionView.backgroundColor = .lightGrayCustom
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section: Int, env) -> NSCollectionLayoutSection in
            switch section {
            case 0:
                return self.createSectionLayout(for: .filterMovie)
            case 1:
                return self.createSectionLayout(for: .movieList)
            
            default:
                return self.createSectionLayout(for: .movieList)
            }
        }
    }
    
    func createSectionLayout(for sectionType: sectionLayout) -> NSCollectionLayoutSection {
        switch sectionType {
        case .filterMovie:
            return self.collectionView.createFilterSection()
        case .movieList:
            return self.collectionView.createMovieSection()
        }
    }
}
